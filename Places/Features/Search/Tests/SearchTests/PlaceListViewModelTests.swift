import Foundation
import Testing
@testable import Search

@MainActor
struct SearchTests {
    var sut: PlaceListViewModel
    var repository: SearchRepositoryFake
    var deeplink: DeeplinkFake
    
    init() async throws {
        repository = SearchRepositoryFake()
        deeplink = DeeplinkFake()
        
        sut = PlaceListViewModel(
            repository: repository,
            deeplink: deeplink
        )
    }
    
    @Test func requestPlacesSuccess() async {
        //Given
        let places = places()
        
        //When
        await sut.requestPlaces()
        
        //Then
        #expect(sut.state == .loaded(places))
    }
    
    @Test func requestPlacesFailure() async {
        //Given
        repository.throwError = true
        
        //When
        await sut.requestPlaces()
        
        //Then
        #expect(sut.state == .error("The operation couldn’t be completed. (Network.NetworkError error 0.)"))
    }
    
    @Test func searchPlace() async {
        //Given
        let places = placeQuery()
        await sut.requestPlaces()
        
        //When
        await sut.searchPlaces("P")
        
        //Then
        #expect(sut.state == .loaded(places))
    }
    
    @Test func searchPlacesReturnEmpty() async {
        //Given
        await sut.requestPlaces()
        
        //When
        await sut.searchPlaces("Z")
        
        //Then
        #expect(sut.state == .loaded([]))
    }
    
    @Test func openPlaceData() async {
        //Given
        let place = placeQuery().first!
        let expectedQueryItems = [
            URLQueryItem(name: "lat", value: "30.0368"),
            URLQueryItem(name: "long", value: "51.209"),
            URLQueryItem(name: "name", value: "Porto Alegre")
        ]
        
        //When
        await sut.openPlace(place)
        
        //Then
        #expect(deeplink.queryItems == expectedQueryItems)
        #expect(deeplink.type == .places)
    }
}
