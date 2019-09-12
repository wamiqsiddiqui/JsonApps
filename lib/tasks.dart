
class Tasks{
  String _taskName;
  String _taskDetails;
  String _taskDate;
  String _taskTime;
  String _taskType;

  Tasks(this._taskName,this._taskDetails,this._taskDate,this._taskTime,this._taskType);

  Tasks.map(dynamic obj)
  {
    this._taskName=obj["taskName"];
    this._taskDetails=obj["taskDetails"];
    this._taskDate=obj["taskDate"];
    this._taskTime=obj["taskTime"];
    this._taskType=obj["taskType"];
  }
  String get taskName => _taskName;
  String get taskDetails=> _taskDetails;
  String get taskDate=>_taskDate;
  String get taskTime=>_taskTime;
  String get taskType=>_taskType;

  Map<String,dynamic> toMap(){
    var map=new Map<String,dynamic>();
    map["taskName"]=_taskName;
    map["taskDetails"]=_taskDetails;
    map["taskDate"]=_taskDate;
    map["taskTime"]=_taskTime;
    map["taskType"]=_taskType;
    return map;
  }

  Tasks.fromMap(Map<String,dynamic>map)
  {
    this._taskName=map["taskName"];
    this._taskDetails=map["taskDetails"];
    this._taskDate=map["taskDate"];
    this._taskTime=map["taskTime"];
    this._taskType=map["taskType"];
  }
}
