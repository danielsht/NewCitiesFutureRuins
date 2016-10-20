import http.requests.*;

GetRequest get;
String dataIn;

void setup(){
  size(200, 200);
  
  get = new GetRequest("http://localhost:5000/CAsequence");
}

void draw() {
  get.send();
  dataIn = get.getContent();
  println(dataIn);
}