<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.UUID"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
 
<%
String return1="";
String return2="";
String return3="";
String name = "";
 
if (ServletFileUpload.isMultipartContent(request)){
    ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
    uploadHandler.setHeaderEncoding("UTF-8");
    List<FileItem> items = uploadHandler.parseRequest(request);
    for (FileItem item : items) {
        if(item.getFieldName().equals("callback")) {
            return1 = item.getString("UTF-8");
        } else if(item.getFieldName().equals("callback_func")) {
            return2 = "?callback_func="+item.getString("UTF-8");
        } else if(item.getFieldName().equals("Filedata")) {
            if(item.getSize() > 0) {
      
                name = item.getName().substring(item.getName().lastIndexOf(File.separator)+1);
                String filename_ext = name.substring(name.lastIndexOf(".")+1);
                filename_ext = filename_ext.toLowerCase();
                String[] allow_file = {"jpg","png","bmp","gif"};
                int cnt = 0;
                for(int i=0; i<allow_file.length; i++) {
                    if(filename_ext.equals(allow_file[i])){
                        cnt++;
                    }
                }
                if(cnt == 0) {
                    return3 = "&errstr="+name;
                } else {
                     
                    //파일 기본경로
                    String dftFilePath = request.getSession().getServletContext().getRealPath("/upload");
                    //파일 기본경로 _ 상세경로
                    String filePath = dftFilePath+File.separator;
                     
                    File file = null;
                    file = new File(filePath);
                    if(!file.exists()) {
                        file.mkdirs();
                    }
                     
                    String realFileNm = "";
                    SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
                    String today= formatter.format(new java.util.Date());
                    realFileNm = today+UUID.randomUUID().toString() + name.substring(name.lastIndexOf("."));
                     
                    String rlFileNm = filePath + realFileNm;
                    ///////////////// 서버에 파일쓰기 ///////////////// 
                    InputStream is = item.getInputStream();
                    OutputStream os=new FileOutputStream(rlFileNm);
                    int numRead;
                    byte b[] = new byte[(int)item.getSize()];
                    while((numRead = is.read(b,0,b.length)) != -1){
                        os.write(b,0,numRead);
                    }
                    if(is != null) {
                        is.close();
                    }
                    os.flush();
                    os.close();
                    ///////////////// 서버에 파일쓰기 /////////////////
                    String contextPath = request.getContextPath(); 
                    return3 += "&bNewLine=true";
                                // img 태그의 title 옵션에 들어갈 원본파일명
                    return3 += "&sFileName="+ name;
                    return3 += "&sFileURL="+contextPath+"/upload/"+realFileNm;
                }
            }else {
                  return3 += "&errstr=error";
            }
        }
    }
}
response.sendRedirect(return1+return2+return3);
 
%>


