<%@page import="pdtb.connessioni.Connessioni"%>
 <html>
 <head>
     <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
     <title>Accesso</title>
 </head>
 <body>

 	<div id="div_log_larga">
		<h1>Accesso...</h1> <br />
	</div>
	<%
		/*
		Richiamo il singletone per registrare le connessioni.
		Registro la nuova connessione e reindirizzo la pagina alla prima pagina dell'applicazione.
		*/
 		Connessioni conAttive = Connessioni.getInstance();
 		conAttive.aggiungiConnessione(request.getParameter("username"));
 		String site = "prima_schermata.jsp";
		response.setStatus(response.SC_MOVED_TEMPORARILY);
		session.setAttribute("username",request.getParameter("username"));
		session.setAttribute("password",request.getParameter("password"));
   		response.setHeader("Location", site);	
 	%>
 </body>
 </html>
