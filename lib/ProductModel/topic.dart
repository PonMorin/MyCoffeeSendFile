class Topic{
  String topic;

  Topic(this.topic);

  Topic.fromMap(Map<String, dynamic> map){
    topic = map["topic"];

  }
}