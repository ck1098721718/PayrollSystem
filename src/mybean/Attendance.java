package mybean;

public class Attendance{
	private String department,id,name,date,event,remark;
	private String oldDate,oldEvent;
	private String backNews;
	public Attendance(){
		
	}
	
	public Attendance(String department, String id, String name, String date, String event, String remark) {
		this.department = department;
		this.id = id;
		this.name = name;
		this.date = date;
		this.event = event;
		this.remark = remark;
	}

	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getEvent() {
		return event;
	}
	public void setEvent(String event) {
		this.event = event;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getBackNews() {
		return backNews;
	}
	public void setBackNews(String backNews) {
		this.backNews = backNews;
	}

	public String getOldDate() {
		return oldDate;
	}

	public void setOldDate(String oldDate) {
		this.oldDate = oldDate;
	}

	public String getOldEvent() {
		return oldEvent;
	}

	public void setOldEvent(String oldEvent) {
		this.oldEvent = oldEvent;
	}
	
	
	
}
