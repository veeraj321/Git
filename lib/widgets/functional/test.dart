

mixin Sketching{
  sketch(String message){
    print(message);
  }
}

abstract class Person{
 int? age;
 String? name;

  eat(){}
  sleep(){}
}

class Artist extends Person with Sketching{
  @override
  sketch(String message) {
    
    print("this is overridng baseclass");
  }
}

main(List<String> args) {
  Artist artist = Artist();
  artist.sketch("sketching for art");
}