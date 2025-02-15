

class HomePageAPIResponse{
  String image;
  String name;
  String information;

  // Private constructor
  HomePageAPIResponse._({
    required this.image,
    required this.name,
    required this.information,
  });

 factory HomePageAPIResponse.fromJson(Map<String,String> data){
    return HomePageAPIResponse._(
        image: data['image']!,
        name: data['name']!,
        information: data['information']!
    );
  }
}