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
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.cj.jdbc.DatabaseMetaData;

import mybean.Salary;
import net.sf.json.JSONArray;

/**
 * Servlet implementation class SalaryCalculation
 */
@WebServlet("/SalaryCalculation")
public class SalaryCalculation extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SalaryCalculation() {
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
			e.printStackTrace();
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
			if(method.equals("query")) {
				int flag=0;;
				String department = request.getParameter("department");
				String year = request.getParameter("year");
				String month = request.getParameter("month");
				int year1 = 0,month1 = 0;
				try {
					year1=Integer.parseInt(year);
				}
				catch(Exception e) {
					flag = 1;
				}
				try {
					month1=Integer.parseInt(month);
					month = String.valueOf(month1);
					if(month1<=0||month1>12)	flag=2;
				}
				catch(Exception e) {
					flag = 2;
				}
				try {
					SimpleDateFormat df = new SimpleDateFormat("yyyy-MM");	//设置日期格式
					String time = df.format(new Date());
					String[] t = time.split("-");
					int year2 = Integer.parseInt(t[0]);
					int month2 = Integer.parseInt(t[1]);
					int temp = year1*360+month1*30-year2*360-month2*30;
					if(temp>0||temp<-3600)	flag = 3;
				}
				catch(Exception e) {
					flag = 3;
				}
				if(flag==0) {
					Connection con;
					Statement sql,sql2,sql3,sql4,sql5;
					ResultSet rs,rs2,rs3,rs4,rs5;
					//数据库操作
					try {
						con = DriverManager.getConnection(Salary.url,Salary.username,Salary.password);
						sql = con.createStatement();
						sql2 = con.createStatement();
						sql3 = con.createStatement();
						sql4 = con.createStatement();
						sql5 = con.createStatement();
						
						String selectRecord ="SELECT * FROM 发放历史 WHERE department='"+department+"'AND date='"+year+"-"+month+"'";
						rs = sql.executeQuery(selectRecord);
						ArrayList<Salary> allCalculation = new ArrayList<Salary>();
						if(!rs.next()) {
							//未发放过
							//获取部门的每一个人
							selectRecord ="SELECT * FROM employee WHERE department='"+department+"'";
							rs2 = sql2.executeQuery(selectRecord);
							while(rs2.next()) {
								int year2 = Integer.parseInt(rs2.getString("time").substring(0, 4));
								int month2 = Integer.parseInt(rs2.getString("time").substring(5, 7));
								if((year2*12+month2)>(year1*12+month1))	continue;
								//给每个人生成一条记录
								Salary salary = new Salary();
								allCalculation.add(salary);
								salary.setId(rs2.getString("id"));
								salary.setDepartment(rs2.getString("department"));
								salary.setName(rs2.getString("name"));
								salary.getMap().put("department", rs2.getString("department"));
								salary.getMap().put("id", rs2.getString("id"));
								salary.getMap().put("name", rs2.getString("name"));
								int sum = 0;
								//查询这个人的固定工资
								selectRecord ="SELECT * FROM 固定项目 WHERE department='"+department+"'AND id='"+salary.getId()+"'AND name='"+salary.getName()+"'";
								rs3 = sql3.executeQuery(selectRecord);
								ResultSetMetaData rsd = rs3.getMetaData();
								while(rs3.next()) {
					            	for(int i = 0; i < rsd.getColumnCount(); i++) {  
					                	String key = rsd.getColumnName(i + 1);
					                	
					                	if(!(key.equals("id")||key.equals("name")||key.equals("department"))) {
					                		
					                		//salary.getMap().put(key, rs3.getString(key));
					                		//查询增减项和是否展示
					                		selectRecord = "SELECT * FROM salaryproject WHERE name='"+key+"'";
					                		rs4 = sql4.executeQuery(selectRecord);
					                		if(rs4.next()) {
					                			if(rs4.getString("affect").equals("减"))		sum-=Integer.parseInt(rs3.getString(key));
					                    		else if(rs4.getString("affect").equals("增"))	sum+=Integer.parseInt(rs3.getString(key));
					                			if(rs4.getString("exhibition").equals("是")) {
					                				salary.getMap().put(key, rs3.getString(key));
					                				salary.getList().add(key);
					                			}
					                		}
					                		
					                	}      
					                }
					            }
								//查询考勤情况
								selectRecord ="SELECT * FROM attendance WHERE id='"+salary.getId()+"'AND date like'"+year+"-"+month+"%'";
								rs3 = sql.executeQuery(selectRecord);
								int a=0,b=0,c=0,d=0,e=0;
								while(rs3.next()) {
									if(rs3.getString("event").equals("迟到"))	a++;
									else if(rs3.getString("event").equals("早退"))	b++;
									else if(rs3.getString("event").equals("病假"))	c++;
									else if(rs3.getString("event").equals("事假"))	d++;
									else if(rs3.getString("event").equals("旷工"))	e++;
								}
								selectRecord ="SELECT * FROM attendance WHERE id='"+salary.getId()+"'AND date like'"+year+"-0"+month+"%'";
								rs3 = sql.executeQuery(selectRecord);
								while(rs3.next()) {
									if(rs3.getString("event").equals("迟到"))	a++;
									else if(rs3.getString("event").equals("早退"))	b++;
									else if(rs3.getString("event").equals("病假"))	c++;
									else if(rs3.getString("event").equals("事假"))	d++;
									else if(rs3.getString("event").equals("旷工"))	e++;
								}
								//查询计算公式
								selectRecord ="SELECT * FROM 计算公式";
								rs3 = sql.executeQuery(selectRecord);
								String name,firstData,symbol,secondData;
								while(rs3.next()) {
									name = rs3.getString("name");
									firstData = rs3.getString("firstData");
									symbol = rs3.getString("symbol");
									secondData = rs3.getString("secondData");
									if(name.equals("迟到扣款")||name.equals("早退扣款")||name.equals("病假扣款")||name.equals("事假扣款")||name.equals("旷工扣款")) {
										int temp = 0,f = 0;
										if(name.equals("迟到扣款"))	f=a;
										else if(name.equals("早退扣款"))	f=b;
										else if(name.equals("病假扣款"))	f=c;
										else if(name.equals("事假扣款"))	f=d;
										else if(name.equals("旷工扣款"))	f=e;
										if(symbol.equals("+")) 		temp=(int)(f+Double.parseDouble(secondData));
										else if(symbol.equals("-"))	temp=(int)(f-Double.parseDouble(secondData));
										else if(symbol.equals("*"))	temp=(int)(f*Double.parseDouble(secondData));
										else if(symbol.equals("/"))	temp=(int)(f/Double.parseDouble(secondData));
										sum = sum-temp;
										salary.getMap().put(name, String.valueOf(temp));
									}
									else {
										selectRecord = "SELECT * FROM salaryproject WHERE name='"+name+"'";
				                		rs4 = sql4.executeQuery(selectRecord);
				                		if(rs4.next()) {
				                			int temp = 0,f=0;
				                			//f=Integer.parseInt(salary.getMap().get(firstData));
				                			selectRecord = "SELECT * FROM 固定项目 WHERE id='"+salary.getId()+"'";
				                			rs5 = sql5.executeQuery(selectRecord);
				                			if(rs5.next()) {
				                				f = Integer.parseInt(rs5.getString(firstData));
				                			}
				                			
				                			if(symbol.equals("+")) 		temp=(int)(f+Double.parseDouble(secondData));
											else if(symbol.equals("-"))	temp=(int)(f-Double.parseDouble(secondData));
											else if(symbol.equals("*"))	temp=(int)(f*Double.parseDouble(secondData));
											else if(symbol.equals("/"))	temp=(int)(f/Double.parseDouble(secondData));
				                			
				                			if(rs4.getString("affect").equals("减")) 	sum = sum-temp;
				                			else if(rs4.getString("affect").equals("增"))	sum = sum+temp;
				                			if(rs4.getString("exhibition").equals("是")) {
				                				salary.getMap().put(name,String.valueOf(temp));
				                			}
				                		}
									}
								}
								salary.getMap().put("sum", String.valueOf(sum));
								/*
								System.out.print(salary.getDepartment()+" "+salary.getId()+" "+salary.getName());
								for(Map.Entry<String, String> m:salary.getMap().entrySet()) {
									System.out.print(" "+m.getKey()+":"+m.getValue());
								}
								System.out.println();
								*/
								
							}
							request.getSession().setAttribute("allCalculation", allCalculation);
							//System.out.println(allCalculation.size());
							if(allCalculation.size()!=0) {
								JSONArray jsonArray = JSONArray.fromObject(allCalculation);
					            response.getWriter().println(jsonArray);
							}
							else response.getWriter().print("未查询到相关员工");
						}
						else {
							//已经发放过，获取发放历史
							String backNews = "已经发放过工资了";
							response.getWriter().print(backNews);
						}
						sql.close();
						sql2.close();
						sql3.close();
						sql4.close();
						sql5.close();
						con.close();
						
					}
					catch(SQLException exp) {
						exp.printStackTrace();
					}
				}
				else {
					String backNews = "输入的日期格式不正确";
					response.getWriter().print(backNews);
				}
			}
			else {
				String department = request.getParameter("department");
				String year = request.getParameter("year");
				String month = request.getParameter("month");
				try {
					month = String.valueOf(Integer.parseInt(month));
				}
				catch(Exception e) {
					
				}
				ArrayList<Salary> allCalculation = (ArrayList<Salary>)request.getSession().getAttribute("allCalculation");
				/*
				for(Salary salary:allCalculation) {
					System.out.print(salary.getDepartment()+" "+salary.getId()+" "+salary.getName());
					for(Map.Entry<String, String> m:salary.getMap().entrySet()) {
						System.out.print(" "+m.getKey()+":"+m.getValue());
					}
					System.out.println();
				}
				*/
				if(allCalculation!=null) {
					System.out.println("部门这月份未发放过工资");
					String selectRecord ="SELECT * FROM 发放历史 WHERE department='"+department+"'AND date='"+year+"-"+month+"'";
					Connection con;
					Statement sql;
					ResultSet rs;
					try {
						con = DriverManager.getConnection(Salary.url,Salary.username,Salary.password);
						sql = con.createStatement();
						rs = sql.executeQuery(selectRecord);
						if(!rs.next()) {
							ArrayList <String> key= new ArrayList<String>();
							for(Map.Entry<String, String> m:allCalculation.get(0).getMap().entrySet()) {
								key.add(m.getKey());
							}
							for(Salary salary:allCalculation) {
								String Record = "INSERT INTO 发放历史"+"(date,";
								for(String s:key) {
									Record +=s+",";
								}
								Record = Record.substring(0,Record.length()-1);
								Record+=") VALUES('"+year+"-"+month+"',";
								for(String s:key) {
									Record +="'"+salary.getMap().get(s)+"',";
								}
								Record = Record.substring(0,Record.length()-1);
								Record+=")";
								try {
									con = DriverManager.getConnection(Salary.url,Salary.username,Salary.password);
									sql = con.createStatement();
									sql.executeUpdate(Record);
									sql.close();
									con.close();
								}
								catch(SQLException exp) {
									exp.printStackTrace();
								}
							}
							String backNews = "发放成功";
							response.getWriter().print(backNews);
						}
						else {
							//已经发放过，获取发放历史
							String backNews = "已经发放过工资了";
							response.getWriter().print(backNews);
						}
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
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
