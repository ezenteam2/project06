package funfun.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import funfun.repository.HT_StoreManageReposi;
import funfun.vo.storeQnA;

@Service
public class HT_StoreManageService {
	
	@Autowired(required=false)
	private HT_StoreManageReposi dao;
	
	public ArrayList<storeQnA> storeQnAList(int sto_code){
		return dao.storeQnAList(sto_code);
	}
}
