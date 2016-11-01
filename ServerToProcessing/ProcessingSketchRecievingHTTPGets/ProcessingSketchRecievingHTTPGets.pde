import http.requests.*;

GetRequest get;
String dataIn;
int previousTime;

void setup(){
  size(200, 200);
  
  get = new GetRequest("http://localhost:5000/CAsequence");
}

void draw() {
  get.send();
  dataIn = get.getContent();
  buttonPress(dataIn);
  //println(dataIn);
}

void buttonPress(String dataIn) {
  if ( !dataIn.equals("") ) {
    JSONObject json = JSONObject.parse(dataIn);
    int timeCode = json.getInt("time");
    if(timeCode != previousTime){
      String city = json.getString("user");
      switch(city) {
        case "city1":
          println(dataIn);
        case "city2":
          println(dataIn);
        case "city3": 
          println(dataIn);
      }
    }
    previousTime = timeCode;
  }
}