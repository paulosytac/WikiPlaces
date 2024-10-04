import Foundation
import class Deeplink.Deeplink
import protocol Deeplink.DeeplinkProtocol
import class Deeplink.Deeplink
import DependencyContainer
import Testing
@testable import Search

@MainActor
@Suite(.serialized)
final class SearchTests {
    var sut: PlaceListViewModel

    init() {
        DependencyContainer.register(
            type: SearchRepositoryProtocol.self,
            SearchRepositoryFake()
        )
        
        DependencyContainer.register(
            type: DeeplinkProtocol.self,
            DeeplinkFake()
        )
        
        sut = PlaceListViewModel()
    }
    
    @Test
    func requestPlacesSuccess() async {
        //Given
        let places = places()
        
        //When
        await sut.requestPlaces()
        
        //Then
        #expect(sut.state == .loaded(places))
    }
    
    @Test
    func searchPlace() async {
        //Given
        let places = placeQuery()
        await sut.requestPlaces()
        
        //When
        await sut.searchPlaces("P")
        
        //Then
        #expect(sut.state == .loaded(places))
    }
    
    @Test
    func searchPlacesReturnEmpty() async {
        //Given
        await sut.requestPlaces()
        
        //When
        await sut.searchPlaces("Z")
        
        //Then
        #expect(sut.state == .loaded([]))
    }
    
    @Test
    func openPlaceData() async {
        //Given
        let place = placeQuery().first!
        let expectedQueryItems = [
            URLQueryItem(name: "lat", value: "30.0368"),
            URLQueryItem(name: "long", value: "51.209"),
            URLQueryItem(name: "name", value: "Porto Alegre")
        ]
        let deeplink = DependencyContainer.resolve(DeeplinkProtocol.self) as! DeeplinkFake
        
        //When
        await sut.openPlace(place)
        
        //Then
        #expect(deeplink.queryItems == expectedQueryItems)
        #expect(deeplink.type == .places)
    }
    
    @Test
    func requestPlacesFailure() async {
        //Given
        let repository = DependencyContainer.resolve(SearchRepositoryProtocol.self) as! SearchRepositoryFake
        repository.throwError = true
        
        //When
        await sut.requestPlaces()
        
        //Then
        #expect(sut.state == .error("The operation couldn’t be completed. (Network.NetworkError error 0.)"))
    }
}
