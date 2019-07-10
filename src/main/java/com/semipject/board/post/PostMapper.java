package com.semipject.board.post;

import java.util.ArrayList;
import java.util.Map;


public interface PostMapper {
  
	//<insert id="create">
	public int insert(PostDTO dto);

	public ArrayList<PostDTO> postList(PostDTO dto);

	public ArrayList<PostDTO> searchlist(Map<String, String> data);

	public PostDTO detail(PostDTO dto);

	
} // PlanMapper end
