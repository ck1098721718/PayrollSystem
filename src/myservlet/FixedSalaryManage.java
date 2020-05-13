package myservlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mybean.Salary;
import net.sf.json.JSONArray;

/**
 * Servlet implementation class FixedSalaryManage
 */
@WebServlet("/FixedSalaryManage")
public class FixedSalaryManage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FixedSalaryManage() {
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
			Connection con;
			Statement sql;
			if(method.equals("query")) {
				String way = request.getParameter("way");
				List<Salary> allFixedSalary = new ArrayList<Salary>();			
				session.setAttribute("allFixedSalary", allFixedSalary);			
				try {
					con = DriverManager.getConnection(Salary.url,Salary.username,Salary.password);
					sql = con.createStatement();
					Statement sql2 = con.createStatement();
					String selectRecord = null;
					if(way.equals("id")||way.equals("department")){
						String value = request.getParameter(way);
						if(value.equals("全部")) {
							selectRecord = "SELECT * FROM 固定项目";
						}
						else selectRecord = "SELECT * FROM 固定项目 WHERE "+way+"='"+value+"'";
					}
					else {
						selectRecord = "SELECT * FROM 固定项目";
					}
					ResultSet rs = sql.executeQuery(selectRecord);
					ResultSetMetaData rsd = rs.getMetaData(); 
					while(rs.next()) {
						Salary salary = new Salary();
						int sum = 0;
		            	for(int i = 0; i < rsd.getColumnCount(); i++) {  
		                	String key = rsd.getColumnName(i + 1);
		                    salary.getMap().put(key, rs.getString(key));
		                    if(key.equals("id")||key.equals("name")||key.equals("department"));
		                    else {
		                    	selectRecord = "SELECT affect FROM salaryproject WHERE name='"+key+"'";
		                    	ResultSet rs2 = sql2.executeQuery(selectRecord);
		                    	if(rs2.next()) {
		                    		if(rs2.getString("affect").equals("减"))		sum-=Integer.parseInt(rs.getString(key));
		                    		else sum+=Integer.parseInt(rs.getString(key));
		                    	}
		                    }
		                }
		            	//判断工资区间
		            	if(way.equals("salary")) {
		            		int min = Integer.parseInt(request.getParameter("min"));
		            		int max = Integer.parseInt(request.getParameter("max"));
		            		if(sum>=min&&sum<=max) {
		            			allFixedSalary.add(salary);
		            		}
		            	}
		            	else allFixedSalary.add(salary);
		            }
					sql.close();
					con.close();
				}
				catch(SQLException e) {
					e.printStackTrace();
				}
				/*
				//转发
				RequestDispatcher dispatcher= request.getRequestDispatcher("fixedSalaryManage.jsp");
				dispatcher.forward(request, response);				
				*/
				JSONArray jsonArray = JSONArray.fromObject(allFixedSalary);
	            response.getWriter().println(jsonArray);
			}
			//修改
			else {
				List<Salary> allFixedSalary = (ArrayList)session.getAttribute("allFixedSalary");
				session.setAttribute("allFixedSalary", allFixedSalary);
				Set<String> keys = allFixedSalary.get(0).getMap().keySet();
				for(int i=0;i<allFixedSalary.size();i++) {
					List<String> s = new ArrayList<String>();
					for(String key:keys) {
						if(!(key.equals("department")||key.equals("id")||key.equals("name"))) {
							s.add(key);
						}
					}
					String updateRecord = "UPDATE 固定项目 SET ";
					for(int j=0;j<s.size();j++) {
						//修改集合中的信息
						allFixedSalary.get(i).getMap().put(s.get(j), request.getParameter(s.get(j)+i));
						//sql语句
						updateRecord = updateRecord+s.get(j)+" ='"+request.getParameter(s.get(j)+i)+"'";
						if(j!=(s.size()-1))	updateRecord=updateRecord+",";
						else updateRecord=updateRecord+"WHERE id='"+request.getParameter("id"+i)+"'";
					}
					try {
						con = DriverManager.getConnection(Salary.url,Salary.username,Salary.password);
						sql = con.createStatement();
						sql.executeUpdate(updateRecord);
						sql.close();
						con.close();
					}
					catch(SQLException e) {
						e.printStackTrace();
					}
						
				}
				/*
				//转发
				RequestDispatcher dispatcher= request.getRequestDispatcher("fixedSalaryManage.jsp");
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
