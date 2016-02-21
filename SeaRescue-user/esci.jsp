<%@page import="pdtb.connessioni.Connessioni"%>
 <html>
 <head>
     <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
     <title>Accesso</title>
 </head>
 <body>

 	<div id="div_log_larga">
		<h1>Uscita...</h1> <br />
	</div>
	<%
		/*
		Richiedo le connessioni attive e rimuovo la connessione attuale,
		reindirizzo la pagina alla schermata di login.
		*/
 		Connessioni conAttive = Connessioni.getInstance();
 		conAttive.rimuoviConnessione(request.getParameter("username"));
 		String site = "index.html";
		response.setStatus(response.SC_MOVED_TEMPORARILY);
   		response.setHeader("Location", site);	
 	%>
 </body>
 </html>
