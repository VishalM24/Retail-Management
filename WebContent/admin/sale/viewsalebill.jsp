<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title> View Sale Bill </title>
<link rel="stylesheet" href="../../style.css">
	
	<%@page import="java.io.*" %>
	<%@page import="java.sql.*" %>
	<%@page import="javax.sql.*" %>
	<%@page import="java.sql.Connection" %>
	<%@page import="java.text.DecimalFormat" %>
	<%
            Class.forName("com.mysql.jdbc.Driver");
    		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rsms","root","dbms");
    		Statement st = con.createStatement();
			double t=0.0;
			%>
    <script type="text/javascript">
    	function addField (argument) {
        	
            <%
            String bill=request.getParameter("billno");
            String Query1 ="select * from sale where bill_no="+bill;
    		ResultSet rs1= st.executeQuery(Query1);
            rs1.next();
    		String did = rs1.getString(2);
            Double net = rs1.getDouble(3);
            DecimalFormat priceFormatter = new DecimalFormat("#0.00");
			String netn=priceFormatter.format(net);
            String date =  rs1.getString(4);
            String Query ="select * from sale_details where bill_no="+bill+" order by code";
    		ResultSet rs= st.executeQuery(Query);
            while(rs.next())
    		{
            %>
            var myTable = document.getElementById("myTable");
            var currentIndex = myTable.rows.length;
            var currentRow = myTable.insertRow(-1);
            
            currentCell = currentRow.insertCell(-1);
            currentCell.innerHTML="<%=rs.getString("code")%>";
            
            <%
            Statement stt = con.createStatement();
            String Query2 ="select * from product where code="+rs.getString("code");
    		ResultSet rs2= stt.executeQuery(Query2);
            rs2.next();
    		String name = rs2.getString(2);
    		double mrp=(double)rs2.getDouble("mrp");
    		double price=(double)rs.getDouble("price");
    		double discount=((mrp-price)/mrp)*100;
    		t=t+ (double)rs.getDouble("total");
            %>
    		currentCell = currentRow.insertCell(-1);
    		currentCell.innerHTML="<%=name%>";
            
            currentCell = currentRow.insertCell(-1);
            currentCell.innerHTML="<%=rs.getString("quantity")%>";
            
            currentCell = currentRow.insertCell(-1);
            currentCell.innerHTML="<%=mrp%>";
            
            currentCell = currentRow.insertCell(-1);
            var a=<%=discount%>.toFixed(2);
            currentCell.innerHTML=a;
            
            currentCell = currentRow.insertCell(-1);
            currentCell.innerHTML="<%=price%>";
            
            currentCell = currentRow.insertCell(-1);
            currentCell.innerHTML="<%=rs.getDouble("total")%>";
            

			<%
    		}
    		%>
        }
    	function printDiv(divName) {
    	     var printContents = document.getElementById(divName).innerHTML;
    	     var originalContents = document.body.innerHTML;

    	     document.body.innerHTML = printContents;

    	     window.print();

    	     document.body.innerHTML = originalContents;
    	}
    	function checkForReturn(){
    		<%
    			String Query2 ="select count(*) from sale_return where bill_no="+bill;
    			ResultSet rs2=st.executeQuery(Query2);
    			rs2.next();
    			%>
    			var a=<%=rs2.getInt(1)%>;
    			if(a>0)
    				document.getElementById("returnbutton").style.display="inline-block";
    			
    	}
    </script>
    <style type="text/css">
    body{
background-color: #3973ac;
}
    	select{
		width:135px;
		height: 35px;
		font-size: 18px;
		padding-left:5px; 
		background: #f9f9f9;
		font-family: 'raleway';
		}
		a{
		text-decoration: none;
		color: black;
		}
		table{
  			border: 1px solid black;
  			width:auto;
  			margin: auto;
   		}
		th, td {
			padding:0px;
			text-align:center;
			border: 1px solid black;
			min-width:120px;
			height: 35px;
		}
		.input{
			border:0px;
			border-radius:0px;
			padding-left:10px;
			width:120px;
			height: 35px;
			font-size: 20px;
			background: #f9f9f9;
			font-family: 'raleway';
		}
		.button{
			border-radius:0px;
			border:none;
			background:#d3d3d3;
			color:black;
			font-size:18px;
			font-variant:small-caps;
			font-weight:bold;
			font-family: 'raleway',sans-serif;
			text-align: center;
			height:35px;
			width:100%;	
		}
		[type="date"]
		{
  			font-family: 'raleway';
  			font-size: 16.7px;
		}
		</style>
</head>
<body onload="changeHeader(),addField(),checkForReturn();">
	<div>
         <jsp:include page="../nav.jsp"></jsp:include>
    </div>
	<div id="printablearea">
			
			<br/><div align="center">
		<button class="button1" style="width:150px;  border-radius: 8px; font-size:20px;" align="center" disabled>Sale Bill</button>
		</div><br/>
				<br>
				<div style="width:1000px;margin: auto;text-align: center;">
					<label style="font-size: 20px;">Bill No.</label>&ensp;
					<input id="billno" type="text" style="font-family: 'raleway';font-size:18px;width: 170px;height: 25px;padding-left: 10px;" readonly="readonly" value="<%=bill%>">
					&emsp;&emsp;&emsp;&emsp;&nbsp;
					<label style="font-size: 20px;">Bill Date</label>&ensp;
					<input id="datepicker" type="date" style="font-family: 'raleway';font-size:18px;width: 170px;height: 30px;padding-left: 10px;"  readonly="readonly"  value="<%=date%>">
					<br/><br/>
					
					<%
					String Query3 ="select name,contact from Customer where id="+did;
		    		ResultSet rs3= st.executeQuery(Query3);
		            rs3.next();
		    		String dname = rs3.getString(1);
		    		String mob=rs3.getString(2);
					%>
					<label style="font-size: 20px;">Customer Mobile</label>&ensp;
					<input id="Customermob" type="text" style="font-family: 'raleway';font-size:18px;width: 170px;height: 25px;padding-left: 10px;" readonly="readonly"  value="<%=mob%>">
					&emsp;&emsp;&emsp;
					<label style="font-size: 20px;">Customer Name</label>&ensp;
					<input id="Customername" type="text" style="font-family: 'raleway';font-size:18px;width: 170px;height: 25px;padding-left: 10px;" readonly="readonly" value="<%=dname%>">
					</div>
					<br/>
				<div>
				<table id="myTable" style="align-content: center;">
					<tr>
						<th style="min-width:120px; max-width:120px; ">Code</th>
						<th style="min-width:190px; ">Name</th>
						
						<th>Quantity</th>
						<th>MRP</th>
						<th>Discount</th>
						<th>Price</th>
						<th>Amount</th>
					</tr>
				</table><br/>
				<table style="align-content: center;" width:auto;
    margin-right: 0px;>
					<%
					double d=((t-net)/t)*100;
					String dd=priceFormatter.format(d);
					String tn=priceFormatter.format(t);
					%>
			
					<tr>
						
						<th>Total</th>
						<td><%=tn%></td>
					</tr>
					<tr>
						<th>Discount</th>
						<td><%=dd%></td>
					</tr>
					<tr>
						
						<th>Net</th>
						<td><%=netn%></td>
					</tr>
				</table>
				</div>
		</div>
		<div style="text-align: center;">
		<br>
		<input type="button" class="button" style="width: 150px;" onclick="printDiv('printablearea');" value="Print" />
		</div>
		<div id="returnbutton"  style="display: none;float: right;">
			<br>
			<input type="button" class="button" style="width: 150px;" onclick="location='../Sale Return/viewsalereturn.jsp?billno=<%=bill %>';" value="Return Bill" />
			&emsp;
		</div>
		
</body>
<%
st.close();
con.close();
%>
</html>