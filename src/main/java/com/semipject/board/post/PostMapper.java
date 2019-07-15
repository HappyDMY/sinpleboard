package com.semipject.board.post;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;


public interface PostMapper {
  
	//<insert id="create">
	public int insert(PostDTO dto);

	public ArrayList<PostDTO> postList(PostDTO dto);

	public ArrayList<PostDTO> searchlist(Map<String, String> data);

	public PostDTO detail(PostDTO dto);

	public int delete(PostDTO dto);

	public int deletefile(PostDTO dto);

	public int update(PostDTO dto);

	public int countListContent(String searchOption, String keyword) throws Exception;

	public List listAll(int start, int end, String searchOption, String keyword);

	public int countListContent(Map<String, String> map);

	public List listAll(Map<String, Object> map);

	
} // PlanMapper end
