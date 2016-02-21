<%@ page import="pdtb.database.Database" %>
<%@ page import="pdtb.connessioni.Connessioni" %>
<%@page import="java.util.Vector"%> 
<%@ page import="pdtb.connessioni.Percorso" %>
 <html>
 <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="stile.css" rel="stylesheet" type="text/css">	
	<title>SeaRescue</title>
 </head>
 <body>
 <jsp:useBean id="connetti" scope="session" class="pdtb.database.Database" /> 
 
 <%
 	/*
 	Salvo username e password in variabili, controllo se la connessione
 	esiste ed è attiva e mi connetto al database
 	*/
	String username = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");
	if(username == null || username.length() == 0) {
		username = request.getParameter("username");
		password = request.getParameter("password");
	}
	Connessioni conAttive = Connessioni.getInstance();
	boolean esiste = conAttive.esisteConnessione(username);
	Database dbase = new Database("test",username,password);
	dbase.connetti();
	request.setAttribute("dblog",dbase);
	%>
 
 <form name="esci" action="esci.jsp" method="post">
 	<input type="hidden" name="username" value=<%=username%> />
	<input class="submit-button" id="submit" type="submit" value="Disconnetti"/>
 </form>
 <div style="position: absolute">
		<img src="img/logo.png" style="height: 120px; margin-left: 1094px; margin-top: -58px; position:fixed" /> 
 </div>
 <div style="text-align:center">

	<%
	
	/*
	Controllo se il database è effettivamente connesso
	altrimenti reindirizzo a pagina di errore
	*/
	int lsuccpath = 0;
	int lattpath = 0;
	int lprecpath = 0;
	String descPrec = "";
	String query2 = "";
	String pathSubstr = "";
	String soluzioneDaStampare = "";
	String queryProblemaSelezionato = "";
	String titolo = "";
	if(dbase.isConnesso()==false || esiste==false) {
		String site = "errore.html";
		response.setStatus(response.SC_MOVED_TEMPORARILY);
		response.setHeader("Location", site);
	}
	else {
	%>
		
	<%
		Percorso percorso = Percorso.getInstance();
		String path = percorso.getePercorso();
		String query = "select distinct tipo_barca from problemi;";
		

		if(path!="") {
			lattpath = path.length();
			lsuccpath = path.length()+2;
			lprecpath = path.length()+1;
			query = "select distinct tipo_problema, soluzione from problemi where mid(tipologia, 2, "+ lattpath +") = '"+ path +"' and length(tipologia)=" + lsuccpath + ";";

			

			pathSubstr = path.substring(0,path.length());

			query2 = "select soluzione from problemi where tipologia = '0" + path + "';";
			}
			if(path.length() == 0) {
			%>
			<h1>Seleziona il tipo barca</h1>
			<%
		}
			else if(path == "" || path.length() < 2) {
			soluzioneDaStampare = "";
			titolo = "Seleziona il problema";
			%>
			<h1><%=titolo%></h1>
			<%
		}

		else {
			Vector vettore2 = dbase.eseguiQuery(query2);
			soluzioneDaStampare = ((String[]) vettore2.elementAt(0))[0];
			queryProblemaSelezionato = "select distinct tipo_problema, soluzione from problemi where mid(tipologia, 2, "+ lattpath +") = '"+ path +"' and length(tipologia)=" + lprecpath + ";";
			Vector vettoreProblemaSelezionato = dbase.eseguiQuery(queryProblemaSelezionato);
			titolo = ((String[]) vettoreProblemaSelezionato.elementAt(0))[0];
			%>
			<div>
			<h1><%=titolo%></h1>
			</div>
			<div style="width: 60%; margin: auto; border: 1px solid white">
			<h3>Soluzione suggerita:<br /><br /> <%=soluzioneDaStampare%> </h3>
		</div>
			<%
		}
		Vector vettore = dbase.eseguiQuery(query);
		
		if(path.length()>1 && vettore.size() > 0) {
		%>
		<h4>Altre possibili cause del problema:<br /></h4>
		<%
	}
		for(int i=0; i<vettore.size(); i++) {
			String[] record = (String[]) vettore.elementAt(i);
			%>
			
			<form name="aggiungiDati<%=i%>" action="update.jsp" method="post">
				<input class="submit-button" id="submit" type="submit" value="<%=record[0]%>" />
				<input type="hidden" name="daAggiungere" value="<%=i+1%>" />
			</form>
			
			<%
	}
	%>

		<form name="aiuto" action="call.html" style="position:absolute; margin-left: -110px; left: 50%; margin-top: 200px">
			<h5>Non sei riuscito a trovare la soluzione?</h5>
			<input class="submit-button" id="submit" type="submit" value="Chiama l'assistenza telefonica" />
		</form>

		
		<%
		
	/*
	Chiudo il collegamento con il database
	*/
	dbase.disconnetti();
	}
		%>
 </body>
 </html>
