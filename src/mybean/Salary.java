package mybean;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Salary {
	public static String forName="com.mysql.cj.jdbc.Driver";
	public static String url="jdbc:mysql://localhost:3306/test";
	public static String username="root";
	public static String password="279540465";
	private String department,id,name;
	private Map<String,String> map;
	private List<String> list;
	private String backNews;
	public Salary(){
		map = new HashMap<String,String>();
		list = new ArrayList<String>();
	}
	public Map<String, String> getMap() {
		return map;
	}
	public void setMap(Map<String, String> map) {
		this.map = map;
	}
	public String getBackNews() {
		return backNews;
	}
	public void setBackNews(String backNews) {
		this.backNews = backNews;
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
	public List<String> getList() {
		return list;
	}
	public void setList(List<String> list) {
		this.list = list;
	}
	@Override
	public String toString() {
		return "Salary [department=" + department + ", id=" + id + ", name=" + name + ", map=" + map + ", list=" + list
				+ ", backNews=" + backNews + "]";
	}
	
	
}
