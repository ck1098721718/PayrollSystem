package myservlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mybean.Salary;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class ReportManage
 */
@WebServlet("/ReportManage")
public class ReportManage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportManage() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init(config);
		try {
			Class.forName(Salary.forName);
		}
		catch(Exception e) {
			
		}
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if(request.getSession(true).getAttribute("login")==null) {
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=utf-8");
			response.getWriter().print("未登录");
		}
		else {
			//设置编码方式
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=utf-8");
			String method = request.getParameter("method");
			if(method.equals("table1")) {
				String way = request.getParameter("way");
				//判断日期填写正确与否
				String start = request.getParameter("start");
				String end = request.getParameter("end");
				int flag = 0;
				int year1 = 0,year2=0,month1=0,month2=0;
				try {
					year1 = Integer.parseInt(start.substring(0, 4));
					month1 = Integer.parseInt(start.substring(5));
					year2 = Integer.parseInt(end.substring(0, 4));
					month2 = Integer.parseInt(end.substring(5));
					if((year1*360+month1*30)>(year2*360+month2*30))	flag = 1;
					if(month1<=0||month1>12||month2<=0||month2>12)	flag = 1;
				}
				catch(Exception e) {
					flag = 1;
				}
				if(flag==0&&way.equals("department")) {
					String department = request.getParameter("department");
					List<Salary> all = new ArrayList<Salary>();
					//先查询该部门的员工
					Connection con;
					Statement sql,sql2,sql3;
					ResultSet rs,rs2,rs3;
					try {
						con = DriverManager.getConnection(Salary.url,Salary.username,Salary.password);
						sql = con.createStatement();
						sql2 = con.createStatement();
						sql3 = con.createStatement();
						String selectRecord="SELECT * FROM 发放历史 WHERE department='"+department+"'";
						rs = sql.executeQuery(selectRecord);
						List<String> allId = new ArrayList<String>();
						
						while(rs.next()) {
							
							String id = rs.getString("id");
							if(!allId.contains(id)) {
								allId.add(id);
								String name = rs.getString("name");
								selectRecord = "SELECT * FROM 发放历史 WHERE department='"+department+"'AND id='"+id+"'AND name='"+name+"'";
								Salary salary = new Salary();
								salary.setId(id);
								salary.setDepartment(department);
								salary.setName(name);
								salary.getMap().put("department", department);
								salary.getMap().put("id", id);
								salary.getMap().put("name", name);
								rs2 = sql2.executeQuery(selectRecord);
								ResultSetMetaData rsd = rs2.getMetaData();
								//int [] sum = new int[rsd.getColumnCount()];
								
								int temp=0;
								while(rs2.next()) {
									
									//temp=0;
									String date = rs2.getString("date");
									int year3 = Integer.parseInt(date.substring(0, 4));
									int month3 = Integer.parseInt(date.substring(5));
									if(((year3*360+month3*30)<=(year2*360+month2*30))&&((year3*360+month3*30)>=(year1*360+month1*30))) {
										temp++;
										if(temp==1) { 
											selectRecord = "SELECT name FROM salaryproject WHERE type='固定项目'AND exhibition='是'";
											rs3 = sql3.executeQuery(selectRecord);
											while(rs3.next()) {
												salary.getList().add(rs3.getString("name"));
											}
										}
										for(int i = 0; i < rsd.getColumnCount(); i++) {
											String key = rsd.getColumnName(i + 1);
											if(!(key.equals("id")||key.equals("name")||key.equals("department")||key.equals("date"))) {
												//sum[i] += Integer.parseInt(rs2.getString(key));
												if(temp==1) {
													//salary.getList().add(key);
													salary.getMap().put(key, "0");
												}
												int sum = Integer.parseInt(salary.getMap().get(key));
												sum += Integer.parseInt(rs2.getString(key));
												salary.getMap().put(key,""+sum);
												
											}
										}
									}
									
								}
								if(temp!=0)	all.add(salary);
							}
							
						}
						
						sql.close();
						sql2.close();
						con.close();
					}
					catch(SQLException exp) {
						exp.printStackTrace();
					}
					if(all.size()!=0) {
						JSONArray jsonArray = JSONArray.fromObject(all);
			            response.getWriter().println(jsonArray);
					}
					else	response.getWriter().print("查询不存在");
					
				}
				else if(flag==0&&way.equals("id")) {
					String id = request.getParameter("id");
					List<Salary> all = new ArrayList<Salary>();
					Connection con;
					Statement sql;
					ResultSet rs;
					Salary salary = new Salary();
					try {
						con = DriverManager.getConnection(Salary.url,Salary.username,Salary.password);
						sql = con.createStatement();	
							String selectRecord = "SELECT * FROM 发放历史 WHERE id='"+id+"'";
							
							salary.setId(id);
							salary.getMap().put("id", id);
							
							rs = sql.executeQuery(selectRecord);
							ResultSetMetaData rsd = rs.getMetaData();
							//int [] sum = new int[rsd.getColumnCount()];
							int temp = 0;
							
							while(rs.next()) {
								
								String date = rs.getString("date");
								int year3 = Integer.parseInt(date.substring(0, 4));
								int month3 = Integer.parseInt(date.substring(5));
								if(((year3*360+month3*30)<=(year2*360+month2*30))&&((year3*360+month3*30)>=(year1*360+month1*30))) {
									temp++;
									if(temp==1) {
										salary.setDepartment(rs.getString("department"));
										salary.setName(rs.getString("name"));
										salary.getMap().put("department", rs.getString("department"));
										salary.getMap().put("name", rs.getString("name"));
									}
									for(int i = 0; i < rsd.getColumnCount(); i++) {
										String key = rsd.getColumnName(i + 1);
										if(!(key.equals("id")||key.equals("name")||key.equals("department")||key.equals("date"))) {
											//sum[i] += Integer.parseInt(rs2.getString(key));
											if(temp==1) {
												//salary.getList().add(key);
												salary.getMap().put(key, "0");
											}
											int sum = Integer.parseInt(salary.getMap().get(key));
											sum += Integer.parseInt(rs.getString(key));
											salary.getMap().put(key,""+sum);
											
										}
									}
								}
							}
							if(temp!=0)	all.add(salary);
						
						sql.close();
						con.close();
					}
					catch(SQLException exp) {
						exp.printStackTrace();
					}
					if(all.size()!=0) {
						JSONArray jsonArray = JSONArray.fromObject(all);
			            response.getWriter().println(jsonArray);
					}
					else response.getWriter().print("查询不存在");
				}
				else {
					response.getWriter().print("日期输入有误");
				}
			}
			else if(method.equals("table2")) {
				String [] department = {"人力资源部","财务部","生产技术部","计划营销部","安全监察部","宣传部","后勤部"};
				String way = request.getParameter("way");
				String date="";
				List<Salary> all = new ArrayList<Salary>();
				//Salary salary = new Salary();
				//salary.getMap().put("部门", department);
				int flag = 0;
				String selectRecord = "";
				//获取系统时间
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM");	//设置日期格式
				String time = df.format(new Date());
				int y = Integer.parseInt(time.substring(0, 4));
				int m = Integer.parseInt(time.substring(5));
				if(way.equals("year")) {
					String year = request.getParameter("year");
					try {
						int temp = Integer.parseInt(year);
						if(temp>y||temp+10<y)	flag = 1;
						date = temp+"";
						
						//salary.getMap().put("年份", date);
						//selectRecord ="SELECT 基本工资 FROM 发放历史 WHERE department='"+department+"'AND date like'"+date+"%'";
						
					}
					catch(Exception e) {
						flag = 1;
					}
				}
				else {
					String year = request.getParameter("year");
					String month = request.getParameter("month");
					try {
						int tmp1 = Integer.parseInt(year);
						int tmp2 = Integer.parseInt(month);
						if(tmp2<=0||tmp2>12)	flag=1;
						else if(tmp1>y)		flag=1;
						else if(tmp1*360+tmp2*30+3600<y*360+m*30)	flag=1;
						else if(tmp1*360+tmp2*30>y*360+m*30)	flag=1;
						date = tmp1+"-"+tmp2;
						//salary.getMap().put("月份", date);
						//selectRecord ="SELECT 基本工资 FROM 发放历史 WHERE department='"+department+"'AND date ='"+date+"'";
					}
					catch(Exception e) {
						flag = 1;
					}
				}
				if(flag==0) {
					Connection con = null;
					Statement sql = null ;
					try {
						con = DriverManager.getConnection(Salary.url,Salary.username,Salary.password);
						sql= con.createStatement();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
					for(int i=0;i<7;i++) {
						Salary salary = new Salary();
						salary.getMap().put("部门", department[i]);
						if(way.equals("year")) {
							salary.getMap().put("年份", date);
							selectRecord ="SELECT 基本工资 FROM 发放历史 WHERE department='"+department[i]+"'AND date like'"+date+"%'";
						}
						else{
							salary.getMap().put("月份", date);
							selectRecord ="SELECT 基本工资 FROM 发放历史 WHERE department='"+department[i]+"'AND date ='"+date+"'";
						}
						
						try {
							
							ResultSet rs = sql.executeQuery(selectRecord);
							int len=0,min=0,max=0,sum=0,temp=0;
							while(rs.next()) {
								len++;
								temp = Integer.parseInt(rs.getString("基本工资"));
								if(temp<min)	min=temp;
								if(temp>max)	max=temp;
								sum+=temp;
							}
							if(len!=0) {
								salary.getMap().put("总基本工资", sum+"");
								salary.getMap().put("平均基本工资", sum/len+"");
								salary.getMap().put("最低基本工资", min+"");
								salary.getMap().put("最高基本工资", max+"");
								all.add(salary);
								//response.getWriter().print(JSONObject.fromObject(salary));
							}
						}
						catch(SQLException exp) {
							exp.printStackTrace();
						}
						
					}
					try {
						sql.close();
						con.close();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
					if(all.size()!=0) {
						JSONArray jsonArray = JSONArray.fromObject(all);
			            response.getWriter().println(jsonArray);
					}
					else {
						response.getWriter().print("未发放工资");
					}
					//response.getWriter().print(JSONObject.fromObject(salary));
					
				}
				else {
					response.getWriter().print("日期输入有误");
				}
			}
			else if(method.equals("table3")) {
				String date="";
				List<Salary> all = new ArrayList<Salary>();
				//Salary salary = new Salary();
				
				int flag = 0;
				String selectRecord = "";
				//获取系统时间
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM");	//设置日期格式
				String time = df.format(new Date());
				int y = Integer.parseInt(time.substring(0, 4));
				int m = Integer.parseInt(time.substring(5));
				
				String year = request.getParameter("year");
				try {
					int temp = Integer.parseInt(year);
					if(temp>y||temp+10<y)	flag = 1;
					date = temp+"";
					//salary.getMap().put("年份", date);
					//selectRecord ="SELECT sum FROM 发放历史 WHERE date like'"+date+"%'";
				}
				catch(Exception e) {
					flag = 1;
				}
				
				
				if(flag==0) {
					Connection con = null;
					Statement sql = null;
					try {
						con = DriverManager.getConnection(Salary.url,Salary.username,Salary.password);
						sql = con.createStatement();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
					for(int i=0;i<12;i++) {
						String d = date+"-"+i;
						Salary salary = new Salary();
						salary.getMap().put("月份", d);
						selectRecord ="SELECT sum FROM 发放历史 WHERE date ='"+d+"'";
						try {
							
							ResultSet rs = sql.executeQuery(selectRecord);
							int len=0,min=0,max=0,sum=0,temp=0;
							while(rs.next()) {
								len++;
								temp = Integer.parseInt(rs.getString("sum"));
								if(temp<min)	min=temp;
								if(temp>max)	max=temp;
								sum+=temp;
							}
							if(len!=0) {
								salary.getMap().put("总工资", sum+"");
								salary.getMap().put("平均工资", sum/len+"");
								salary.getMap().put("最低工资", min+"");
								salary.getMap().put("最高工资", max+"");
								//response.getWriter().print(JSONObject.fromObject(salary));
								all.add(salary);
							}
						}
						catch(SQLException exp) {
							exp.printStackTrace();
						}
					}
					try {
						sql.close();
						con.close();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
					//response.getWriter().print(JSONObject.fromObject(salary));
					if(all.size()!=0) {
						JSONArray jsonArray = JSONArray.fromObject(all);
			            response.getWriter().println(jsonArray);
					}
					else {
						response.getWriter().print("未发放工资");
					}
				}
				else {
					response.getWriter().print("日期输入有误");
				}
			}
			else if(method.equals("table4")) {
				List<Salary> all = new ArrayList<Salary>();
				String way = request.getParameter("way");
				//String id = request.getParameter("id");
				String date="";
				//Salary salary = new Salary();
				//salary.setId(id);
				//salary.getMap().put("id", id);
				int flag = 0;
				String selectRecord = "";
				//获取系统时间
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM");	//设置日期格式
				String time = df.format(new Date());
				int y = Integer.parseInt(time.substring(0, 4));
				int m = Integer.parseInt(time.substring(5));
				if(way.equals("year")) {
					String year = request.getParameter("year");
					try {
						int temp = Integer.parseInt(year);
						if(temp>y||temp+10<y)	flag = 1;
						date = temp+"";
						//salary.getMap().put("年份", date);
						//selectRecord ="SELECT * FROM 发放历史 WHERE id='"+id+"'AND date like'"+date+"%'";
					}
					catch(Exception e) {
						flag = 1;
					}
				}
				else {
					String year = request.getParameter("year");
					String month = request.getParameter("month");
					try {
						int tmp1 = Integer.parseInt(year);
						int tmp2 = Integer.parseInt(month);
						if(tmp2<=0||tmp2>12)	flag=1;
						else if(tmp1>y)		flag=1;
						else if(tmp1*360+tmp2*30+3600<y*360+m*30)	flag=1;
						else if(tmp1*360+tmp2*30>y*360+m*30)	flag=1;
						date = tmp1+"-"+tmp2;
						//salary.getMap().put("月份", date);
						//selectRecord ="SELECT * FROM 发放历史 WHERE id='"+id+"'AND date ='"+date+"'";
					}
					catch(Exception e) {
						flag = 1;
					}
				}
				if(flag==0) {
					try {
						Connection con = DriverManager.getConnection(Salary.url,Salary.username,Salary.password);
						Statement sql = con.createStatement();
						Statement sql2 = con.createStatement();
						ResultSet rs2 = sql2.executeQuery("SELECT * FROM 发放历史");
						List<String> allid = new ArrayList<String>();
						while(rs2.next()) {
							String id = rs2.getString("id");
							if(!allid.contains(id)) {
								allid.add(id);
								Salary salary = new Salary();
								salary.getMap().put("id", id);
								salary.getMap().put("department", rs2.getString("department"));
								salary.getMap().put("name", rs2.getString("name"));
								if(way.equals("year")) {
									salary.getMap().put("年份", date);
									selectRecord ="SELECT * FROM 发放历史 WHERE id='"+id+"'AND date like'"+date+"%'";
								}
								else {
									salary.getMap().put("月份", date);
									selectRecord ="SELECT * FROM 发放历史 WHERE id='"+id+"'AND date ='"+date+"'";
								}
								ResultSet rs = sql.executeQuery(selectRecord);
								ResultSetMetaData rsd = rs.getMetaData();
								int len=0;
								while(rs.next()) {
									len++;
									for(int i = 0; i < rsd.getColumnCount(); i++) {
										String key = rsd.getColumnName(i + 1);
										if(!(key.equals("id")||key.equals("name")||key.equals("department")||key.equals("date"))) {
											//sum[i] += Integer.parseInt(rs2.getString(key));
											if(len==1) {
												//salary.getList().add(key);
												salary.getMap().put(key, "0");
											}
											int sum = Integer.parseInt(salary.getMap().get(key));
											sum += Integer.parseInt(rs.getString(key));
											salary.getMap().put(key,""+sum);
											
										}
									}
								}
								if(len!=0) {
									all.add(salary);
									//JSONArray jsonArray = JSONArray.fromObject(all);
						            //response.getWriter().println(jsonArray);
								}
								//else	response.getWriter().print("未发放工资");
							}
						}
						sql.close();
						sql2.close();
						con.close();
						if(all.size()!=0) {
							JSONArray jsonArray = JSONArray.fromObject(all);
				            response.getWriter().println(jsonArray);
						}
						else	response.getWriter().print("未发放工资");
						
						
						
					}
					catch(SQLException exp) {
						exp.printStackTrace();
					}
					//response.getWriter().print(JSONObject.fromObject(salary));
					
				}
				else {
					response.getWriter().print("日期输入有误");
				}
				
				
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
