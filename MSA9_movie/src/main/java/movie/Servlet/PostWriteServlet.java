package movie.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import movie.DTO.Files;
import movie.DTO.Posts;
import movie.DTO.Users;
import movie.Service.FileService;
import movie.Service.FileServiceImpl;
import movie.Service.PostService;
import movie.Service.PostServiceImpl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/postWrite_pro.jsp")
@MultipartConfig
public class PostWriteServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int fileResult = 0;
        String mode = "insert";
        int postNo = 0;

        // 로그인한 유저 정보 가져오기
        Users user = (Users) request.getSession().getAttribute("loginUser");
        

        // Posts 객체 생성
        Posts post = new Posts();
        post.setUserNo(user.getUserNo()); // userNo 세팅
        
        // 파일 업로드 경로
        String path = "C:/upload"; // 실제 업로드 경로

        // 폴더 생성
        File uploadDir = new File(path);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // 서비스 설정
        PostService postService = new PostServiceImpl();
        FileService fileService = new FileServiceImpl();

        // 파일 업로드 처리
        List<String> filePaths = new ArrayList<>();

        // 파일 파트 가져오기
        for (Part part : request.getParts()) {
            String fieldName = part.getName();

            // 일반 데이터 처리
            if (part.getContentType() == null) {
                String value = request.getParameter(fieldName);
                if (fieldName.equals("content")) {
                    post.setContent(value); // content 내용 post객체에 세팅
                } else if (fieldName.equals("keywordNo") && !value.isEmpty() && !value.equals("null")) {
                    post.setKeywordNo(Integer.parseInt(value)); // keywordNo 세팅
                } else if (fieldName.equals("movieNo") && !value.isEmpty() && !value.equals("null")) {
                    post.setMovieNo(Integer.parseInt(value)); // movieNo 세팅
                } else if (fieldName.equals("postNo") && !value.isEmpty() && !value.equals("null")) {
                    postNo = Integer.parseInt(value); // update 모드일경우 postNo 담겨옴
                } else if (fieldName.equals("mode") && !value.isEmpty() && !value.equals("null")) {
                    mode = value; // update인지 insert인지 체크
                }
            } 
            // 파일 데이터 처리
            else {
                String fileName = part.getSubmittedFileName();
                File file = new File(path + "/" + fileName);
                part.write(file.getPath());
                filePaths.add(path + "/" + fileName);
            }
        }

        // 데이터베이스에 저장
        if (postNo == 0) {
            int lastPK = postService.insertKey(post);
            if (lastPK > 0) {
                for (String str : filePaths) {
                    Files file = new Files();
                    file.setFileUrl(str);
                    file.setPostNo(lastPK);
                    fileResult += fileService.insert(file);
                }
            }
        } else {
            post.setPostNo(postNo);
            postService.update(post);
            // 기존 파일 정보 불러오기
            List<Files> oldList = fileService.list(postNo);
            // 기존 파일들 삭제
            for (Files file : oldList) {
                File oldFile = new File(file.getFileUrl());
                if (oldFile.exists()) {
                    oldFile.delete();
                }
            }
            // 기존 파일 DB 정보 삭제
            fileService.deleteByPostNo(postNo);
            // 파일 정보 DB에 입력
            for (String str : filePaths) {
                Files file = new Files();
                file.setFileUrl(str);
                file.setPostNo(postNo);
                fileResult += fileService.insert(file);
            }
        }

        response.getWriter().println(fileResult);
    }
}
