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
	  private String uploadPath = "uploadpic/upload/"; // �ϴ��ļ���Ŀ¼    
	    private String tempPath = "uploadpic/uploadtmp/"; // ��ʱ�ļ�Ŀ¼    
	    private String serverPath = null;   
	    private String[] fileType = new String[]{".jpg",".gif",".bmp",".png",".jpeg",".ico"};  
	    private int sizeMax = 8;//ͼƬ�������    
	    private int code = 0; //״̬��
	    private String msg = "δ��ʼ��"; //������Ϣ 
	    @Override  
	    protected void doPost(HttpServletRequest request, HttpServletResponse response)  
	            throws ServletException, IOException {  
	        // �������˸�Ŀ¼  
	        String serverPath = getServletContext().getRealPath("/").replace("\\", "/");    
//	        System.out.println(serverPath);  
	        //Servlet��ʼ��ʱִ��,����ϴ��ļ�Ŀ¼���������Զ�����    
	        if(!new File(serverPath+uploadPath).isDirectory()){   
	            new File(serverPath+uploadPath).mkdirs();    
	        }    
	        if(!new File(serverPath+tempPath).isDirectory()){  
	            new File(serverPath+tempPath).mkdirs();  
	        }   
	        DiskFileItemFactory factory = new DiskFileItemFactory();  
	        factory.setSizeThreshold(5*1024); //��󻺴�    
	        factory.setRepository(new File(serverPath+tempPath));//��ʱ�ļ�Ŀ¼    
	            
	        ServletFileUpload upload = new ServletFileUpload(factory);  
	        upload.setSizeMax(sizeMax*1024*1024);//�ļ��������   
	            
	        String filePath = null;    
	        try {    
	            List<FileItem> items = upload.parseRequest(request);//��ȡ�����ļ��б�   
	            //  
	            for (int i=0;i<items.size();i++) {  
	                //����һ��forѭ������ȡһ�е�����  
	                FileItem item = items.get(i);  
	                	if(!item.isFormField()){//�ļ���    
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
	         	            msg = "��ȷ���ϴ����ͣ�";
	                    }  
	                }else {  
	                   //����ͼƬ
	                	code = 0;
	    	            msg = "���ϴ�ͼƬ��";
	                }  
	                  
	            }   
	        } catch (Exception e) {  
	            e.printStackTrace();    
	            code = 0;
	            msg = "�����쳣����";
				/* request.setAttribute("errorMsg", "�ϴ�ʧ��,��ȷ���ϴ����ļ����ڲ���������ͼƬ!"); */
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
