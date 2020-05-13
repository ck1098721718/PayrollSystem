package myservlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mybean.Attendance;
import mybean.Employee;
import mybean.Formula;
import mybean.Salary;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class SalaryProjectManage
 */
@WebServlet("/SalaryProjectManage")
public class SalaryProjectManage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SalaryProjectManage() {
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
		//检查是否登陆
		if(request.getSession(true).getAttribute("login")==null) {
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=utf-8");
			response.getWriter().print("未登录");
		}
		else {
			//设置编码方式
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=utf-8");
			//request操作
			String method = request.getParameter("method");
			HttpSession session=request.getSession(true); 
			//数据库对象声明
			Connection con = null;
			Statement sql = null;
			if(method.equals("query")) {
				String way = request.getParameter("way");
				List<Salary> allSalaryProject = new ArrayList<Salary>();			
				session.setAttribute("allSalaryProject", allSalaryProject);			
				try {
					con = DriverManager.getConnection(Salary.url,Salary.username,Salary.password);
					sql = con.createStatement();
					String selectRecord = null;
					if(way.equals("all")) selectRecord = "SELECT * FROM salaryProject";
					else {
						String value = request.getParameter(way);
						if(value.equals("全部"))	selectRecord = "SELECT * FROM salaryProject";
						else selectRecord = "SELECT * FROM salaryProject WHERE "+way+"='"+value+"'";
					}
					ResultSet rs = sql.executeQuery(selectRecord);
					ResultSetMetaData rsd = rs.getMetaData(); 
					while(rs.next()) {
						Salary salary = new Salary();
		            	for(int i = 0; i < rsd.getColumnCount(); i++) {  
		                	String key = rsd.getColumnName(i + 1);
		                    salary.getMap().put(key, rs.getString(key));
		                }
		            	allSalaryProject.add(salary);
		            }
					sql.close();
					con.close();
				}
				catch(SQLException e) {
					e.printStackTrace();
				}
				Collections.sort(allSalaryProject, new Comparator<Salary>() {

					@Override
					public int compare(Salary o1, Salary o2) {
						// TODO Auto-generated method stub
						int first = Integer.parseInt(o1.getMap().get("orderNum"));
						int second = Integer.parseInt(o2.getMap().get("orderNum"));
						if(first>second)	return 1;
						else if(first<second)	return -1;
						else return 0;
					}
					
				});
				JSONArray jsonArray = JSONArray.fromObject(allSalaryProject);
	            response.getWriter().println(jsonArray);
				/*
				//转发
				RequestDispatcher dispatcher= request.getRequestDispatcher("salaryProjectManage.jsp");
				dispatcher.forward(request, response);				
				*/
			}
			else if(method.equals("add")) {
				String type = request.getParameter("type");
				String name = request.getParameter("name");
				String exhibition = request.getParameter("exhibition");
				String affect = request.getParameter("affect");
				String orderNum ="";
				int flag = 0;
				Salary salary = new Salary();
				request.setAttribute("salary",salary);
				//判断。。。
				if(name==null||name.length()==0) {
					flag = 1;
				}
				String backNews="";
				//数据库操作
				try {
					con = DriverManager.getConnection(Salary.url,Salary.username,Salary.password);
					sql = con.createStatement();
					String selectRecord="";
					for(int i=1;;i++) {
						selectRecord="SELECT * FROM salaryproject WHERE orderNum='"+i+"'";	
						ResultSet rs = sql.executeQuery(selectRecord);
						if(!rs.next()) {
							orderNum = String.valueOf(i);
							break;
						}
					}					
					String insertRecord = "INSERT INTO salaryproject VALUES ('"+type+"','"+name+"','"+exhibition+"','"+affect+"','"+orderNum+"')";
									
					if(flag==0) {
						int m = sql.executeUpdate(insertRecord);
						//在对应项目的表中加入这一工资项目
						insertRecord="ALTER TABLE "+type+" ADD "+name+" varchar(32) NOT NULL DEFAULT 0 COMMENT ''";
						sql.execute(insertRecord);
						try {
							//在发放历史中添加
							if(exhibition.equals("是")) {
								insertRecord="ALTER TABLE 发放历史 ADD "+name+" varchar(32) NOT NULL DEFAULT 0 COMMENT ''";
								sql.execute(insertRecord);
							}
						}
						catch(SQLException exp) {
							
						}
						//在计算公式中添加
						if(type.equals("计算项目")) {
							insertRecord = "INSERT INTO 计算公式(name)VALUES('"+name+"')";
							sql.executeUpdate(insertRecord);
						}
						
						if(m!=0) {
							//添加成功
							backNews="添加成功";
							salary.getMap().put("type", type);
							salary.getMap().put("name", name);
							salary.getMap().put("exhibition", exhibition);
							salary.getMap().put("affect", affect);
							salary.getMap().put("orderNum", orderNum);
							((ArrayList)request.getSession().getAttribute("allSalaryProject")).add(salary);
						}
						else {
							 backNews="添加失败";
							 
						}
						con.close();
					}
				}
				catch(SQLException exp) {
					flag = 1;	//名字相同
					exp.printStackTrace();
				}
				switch(flag) {
				case 1:backNews="名字不能为空";break;
				case 2:backNews="名字已存在";break;
				}
				salary.setBackNews(backNews);
				/*
				RequestDispatcher dispatcher= request.getRequestDispatcher("salaryProjectManage.jsp");
				dispatcher.forward(request, response);	
				*/			
				response.getWriter().print(JSONObject.fromObject(salary));
			}
			else if(method.equals("delete")) {
				//删除工资项目
				String name = request.getParameter("name");
				String type = "";
				String orderNum = "";
				//数据库操作
				try {
					con = DriverManager.getConnection(Salary.url,Salary.username,Salary.password);
					sql = con.createStatement();
					String selectRecord = "SELECT * FROM salaryproject WHERE name='"+name+"'";
					ResultSet rs=sql.executeQuery(selectRecord);
					if(rs.next()) {
						type = rs.getString("type");
						orderNum = rs.getString("orderNum");
					}
					sql.close();
					con.close();
				}
				catch(SQLException e) {
					e.printStackTrace();
				}
				
				Iterator<Salary> iter = ((ArrayList)request.getSession().getAttribute("allSalaryProject")).iterator();
				while(iter.hasNext()) {
					Salary salary = iter.next();
					if(salary.getMap().get("name").equals(name)) {
						iter.remove();
					}
				}
				//数据库操作
				try {
					con = DriverManager.getConnection(Salary.url,Salary.username,Salary.password);
					sql = con.createStatement();
					Statement sql2 = con.createStatement();
					String deleteRecord = "DELETE FROM salaryproject WHERE name='"+name+"'";
					sql.executeUpdate(deleteRecord);
					String selectRecord="";
					String updateRecord="";
					ResultSet rs;
					//修改后面的序号
					for(int i=Integer.parseInt(orderNum)+1;;i++) {
						selectRecord = "SELECT * FROM salaryproject WHERE orderNum='"+i+"'";
						rs=sql.executeQuery(selectRecord);
						if(rs.next()) {
							updateRecord="UPDATE salaryproject SET orderNum='"+(i-1)+"'WHERE orderNum='"+i+"'";
							sql2.executeUpdate(updateRecord);
						}
						else {
							break;
						}				
					}
					
					
					if(type.equals("计算项目")) {
						deleteRecord = "DELETE FROM 计算公式 WHERE name='"+name+"'";
						sql.executeUpdate(deleteRecord);
					}
					
					//删除指定项目
					deleteRecord = "ALTER TABLE "+type+" DROP "+name;
					System.out.println(deleteRecord);
					sql.execute(deleteRecord);
					sql.close();
					con.close();
				}
				catch(SQLException e) {
					e.printStackTrace();
				}
				/*
				//转发
				RequestDispatcher dispatcher= request.getRequestDispatcher("salaryProjectManage.jsp");
				dispatcher.forward(request, response);
				*/
				
				
				
			}
			else if(method.equals("update")){
				//修改工资项目
				String type = request.getParameter("type");
				String name = request.getParameter("name");
				String exhibition = request.getParameter("exhibition");
				String affect = request.getParameter("affect");
				String oldName = request.getParameter("oldName");
				String oldType = request.getParameter("oldType");
				int flag = 0;
				Salary salary = new Salary();
				request.setAttribute("salary",salary);
				salary.getMap().put("oldName", oldName);
				salary.getMap().put("type", type);
				salary.getMap().put("name", name);
				salary.getMap().put("exhibition", exhibition);
				salary.getMap().put("affect", affect);
				//判断。。。
				if(name==null||name.length()==0) {
					flag = 1;
				}
				
				try {
					con = DriverManager.getConnection(Salary.url,Salary.username,Salary.password);
					sql = con.createStatement();

					if(flag==0) {
						String updateRecord = "UPDATE salaryproject SET type='"+type+"',name='"+name+"',exhibition='"+exhibition+"',affect='"+affect+"' WHERE name='"+oldName+"'";
						sql.executeUpdate(updateRecord);
						
				        List<Salary> allSalaryProject = (ArrayList)request.getSession().getAttribute("allSalaryProject");
				        for(Salary e:allSalaryProject) {
				        	if(e.getMap().get("name").equals(oldName)) {
				        		e.getMap().put("type", type);
				        		e.getMap().put("name", name);
				        		e.getMap().put("exhibition", exhibition);
				        		e.getMap().put("affect", affect);
				        	}
				        }
				        request.getSession().setAttribute("allSalaryProject", allSalaryProject);
				        try {
				        	//在发放历史中添加
				        	if(exhibition.equals("是")) {
								String insertRecord="ALTER TABLE 发放历史 ADD "+name+" varchar(32) NOT NULL DEFAULT 0 COMMENT ''";
								sql.execute(insertRecord);
							}
				        }
				        catch(SQLException e) {
				        	
				        }
				        //修改对应项目中的数据库
				        if(oldType.equals(type)) {
				        	if(!oldName.equals(name)) {
				        		updateRecord="ALTER TABLE "+type+" CHANGE "+oldName+" "+ name+" varchar(32) DEFAULT 0";
				        		sql.execute(updateRecord);
				        		if(type.equals("计算项目")) {
				        			updateRecord="UPDATE 计算公式 SET name='"+name+"' WHERE name='"+oldName+"'";
				        			sql.executeUpdate(updateRecord);
				        		}
				        	}
				        }
				        else {
				        	updateRecord="ALTER TABLE "+oldType+" DROP "+oldName;
				        	sql.execute(updateRecord);
				        	updateRecord="ALTER TABLE "+type+" ADD "+name+" varchar(32) NOT NULL DEFAULT 0 COMMENT ''";
				        	sql.execute(updateRecord);
				        	if(oldType.equals("计算项目")) {
				        		updateRecord="DELETE FROM 计算公式 WHERE name='"+oldName+"'";
				        		sql.executeUpdate(updateRecord);
				        	}
				        	else if(type.equals("计算项目"))	{
				        		updateRecord="INSERT INTO 计算公式(name) VALUES('"+name+"')";
				        		sql.executeUpdate(updateRecord);
				        	}
				        }				        
					}
					sql.close();
					con.close();
				}
				catch(SQLException e) {
					e.printStackTrace();
					flag = 2;
				}
				//返回消息
		        String backNews="修改成功";
		        switch(flag) {
		        case 1:backNews="名字不能为空";break;
		        case 2:backNews="名字已存在";break;
		        }
		        salary.setBackNews(backNews);
		        /*
		        //转发
		        RequestDispatcher dispatcher= request.getRequestDispatcher("salaryProjectManage.jsp");
				dispatcher.forward(request, response);
				*/
		        response.getWriter().print(JSONObject.fromObject(salary));
			}
			else if(method.equals("set1")){
				List<Formula> allFormula = new ArrayList<Formula>();	
				request.setAttribute("allFormula",  allFormula);			
				try {
					con = DriverManager.getConnection(Salary.url,Salary.username,Salary.password);
					sql = con.createStatement();
					String selectRecord = "SELECT * FROM 计算公式";					
					ResultSet rs = sql.executeQuery(selectRecord);
					while(rs.next()) {
						String name = rs.getString("name");
						if(name.equals("迟到扣款")||name.equals("早退扣款")||name.equals("病假扣款")||name.equals("事假扣款")||name.equals("旷工扣款")) {
							String firstData = rs.getString("firstData");
							String secondData = rs.getString("secondData");
							String symbol = rs.getString("symbol");
							Formula formula = new Formula(name,firstData,secondData,symbol);
							allFormula.add(formula);
						}
		            }				
					rs = sql.executeQuery(selectRecord);
					while(rs.next()) {
						String name = rs.getString("name");
						if(!(name.equals("迟到扣款")||name.equals("早退扣款")||name.equals("病假扣款")||name.equals("事假扣款")||name.equals("旷工扣款"))) {
							String firstData = rs.getString("firstData");
							String secondData = rs.getString("secondData");
							String symbol = rs.getString("symbol");
							Formula formula = new Formula(name,firstData,secondData,symbol);
							allFormula.add(formula);
						}
		            }
					selectRecord = "SELECT name FROM salaryproject WHERE type = '固定项目'";
					rs = sql.executeQuery(selectRecord);
					while(rs.next()) {
						allFormula.get(0).getFixed().add(rs.getString("name"));
					}
					sql.close();
					con.close();
				}
				catch(SQLException e) {
					e.printStackTrace();
				}
				
				JSONArray jsonArray = JSONArray.fromObject(allFormula);
	            response.getWriter().println(jsonArray);
				/*
				RequestDispatcher dispatcher= request.getRequestDispatcher("setFormula.jsp");
				dispatcher.forward(request, response);	
				*/
				
			}
			else if(method.equals("set2")) {
				int flag = 0;
				try {
					con = DriverManager.getConnection(Salary.url,Salary.username,Salary.password);
					sql = con.createStatement();
				}catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				for(int i=0;i<Integer.parseInt(request.getParameter("size"));i++) {
					String name=request.getParameter("name"+i);
					String firstData=request.getParameter("firstData"+i);
					String secondData=request.getParameter("secondData"+i);
					try {
						Double.parseDouble(secondData);
					}
					catch(Exception e) {
						flag = 1;
						break;
					}
					String symbol=request.getParameter("symbol"+i);
					String updateRecord="UPDATE 计算公式 SET firstData='"+firstData+"',secondData='"+secondData+"',symbol='"+symbol+"' WHERE name='"+name+"'";
					try {	
						sql.executeUpdate(updateRecord);
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
				}
				try {
					sql.close();
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				String backNews="";
				if(flag==0)	backNews="保存成功";
				else	backNews="浮点数输入有误";
				response.getWriter().print(backNews);
				/*
				RequestDispatcher dispatcher= request.getRequestDispatcher("salaryProjectManage.jsp");
				dispatcher.forward(request, response);	
				*/
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
