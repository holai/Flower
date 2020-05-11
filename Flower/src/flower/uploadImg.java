package flower;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet("/upload")
public class uploadImg extends HttpServlet {
	  private String uploadPath = "uploadpic/upload/"; // 上传文件的目录    
	    private String tempPath = "uploadpic/uploadtmp/"; // 临时文件目录    
	    private String serverPath = null;   
	    private String[] fileType = new String[]{".jpg",".gif",".bmp",".png",".jpeg",".ico"};  
	    private int sizeMax = 8;//图片最大上限    
	    private int code = 0; //状态码
	    private String msg = "未初始化"; //返回消息 
	    @Override  
	    protected void doPost(HttpServletRequest request, HttpServletResponse response)  
	            throws ServletException, IOException {  
	        // 服务器端根目录  
	        String serverPath = getServletContext().getRealPath("/").replace("\\", "/");    
//	        System.out.println(serverPath);  
	        //Servlet初始化时执行,如果上传文件目录不存在则自动创建    
	        if(!new File(serverPath+uploadPath).isDirectory()){   
	            new File(serverPath+uploadPath).mkdirs();    
	        }    
	        if(!new File(serverPath+tempPath).isDirectory()){  
	            new File(serverPath+tempPath).mkdirs();  
	        }   
	        DiskFileItemFactory factory = new DiskFileItemFactory();  
	        factory.setSizeThreshold(5*1024); //最大缓存    
	        factory.setRepository(new File(serverPath+tempPath));//临时文件目录    
	            
	        ServletFileUpload upload = new ServletFileUpload(factory);  
	        upload.setSizeMax(sizeMax*1024*1024);//文件最大上限   
	            
	        String filePath = null;    
	        try {    
	            List<FileItem> items = upload.parseRequest(request);//获取所有文件列表   
	            //  
	            for (int i=0;i<items.size();i++) {  
	                //里面一个for循环，获取一行的数据  
	                FileItem item = items.get(i);  
	                	if(!item.isFormField()){//文件名    
	                    String fileName = item.getName().toLowerCase();  
	                    if(fileName.endsWith(fileType[0])||fileName.endsWith(fileType[1])||fileName.endsWith(fileType[2])||fileName.endsWith(fileType[3])||fileName.endsWith(fileType[4])||fileName.endsWith(fileType[5])){       
							/* filePath = serverPath+uploadPath+fileName; */ 
	                        String hz = fileName.substring(fileName.lastIndexOf("."));
	                        Date date = new Date();
	                        filePath = uploadPath+date.getTime()+hz;
	                        
	                        File file = new File(serverPath+filePath);  
	                        item.write(file); 
	                        code = 1;
	         	            msg = filePath;
	                     }else {  
	                    	 code = 0;
	         	            msg = "请确认上传类型！";
	                    }  
	                }else {  
	                   //不是图片
	                	code = 0;
	    	            msg = "请上传图片！";
	                }  
	                  
	            }   
	        } catch (Exception e) {  
	            e.printStackTrace();    
	            code = 0;
	            msg = "发送异常错误";
				/* request.setAttribute("errorMsg", "上传失败,请确认上传的文件存在并且类型是图片!"); */
				/* request.getRequestDispatcher("upload.jsp").forward(request,response); */
	        }  
	    
	        response.getWriter().println("{\"code\":"+code+",\"msg\":\""+msg+"\"}");
	    }  
	      
	    @Override  
	    protected void doGet(HttpServletRequest req, HttpServletResponse resp)  
	            throws ServletException, IOException {  
	        this.doPost(req, resp);  
	    }  
}
