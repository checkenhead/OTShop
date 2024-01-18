package ot.team1.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ot.team1.dao.ILogisDao;

@Service
public class LogisService {
	
	@Autowired
	ILogisDao ldao;

	public HashMap<String, Object> getLogis(String logisid) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("logisid", logisid);
		paramMap.put("rfcursor", null);
		
		ldao.getLogis(paramMap);
		
		ArrayList<HashMap<String, Object>> list =
				(ArrayList<HashMap<String, Object>>) paramMap.get("rfcursor");
		
		return ( list == null || list.size() == 0 ) ? null : list.get(0);
	}

	public void insertInvoice(
			String clientid, int ordernum, String recipient, String tel, String zipnum, String address1, String address2, String address3) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("clientid", clientid);
		paramMap.put("ordernum", ordernum);
		paramMap.put("recipient", recipient);
		paramMap.put("tel", tel);
		paramMap.put("zipnum", zipnum);
		paramMap.put("address1", address1);
		paramMap.put("address2", address2);
		paramMap.put("address3", address3);
		
		ldao.insertInvoice(paramMap);
	}

	public String getInvoiceStateByIseq(int iseq) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("iseq", iseq);
		paramMap.put("state", "");
		
		ldao.getInvoiceStateByIseq(paramMap);
		
		return ((String)paramMap.get("state")).trim();
	}
	
	public String getInvoiceStateByIdAndOrdernum(String clientid, int ordernum) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("clientid", clientid);
		paramMap.put("ordernum", ordernum);
		paramMap.put("state", "");
		
		ldao.getInvoiceStateByIdAndOrdernum(paramMap);
		
		return ((paramMap.get("state") == null) ? null : ((String)paramMap.get("state"))).trim();
	}

	public int getInvoicenumByIdAndOrdernum(String clientid, int ordernum) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("clientid", clientid);
		paramMap.put("ordernum", ordernum);
		paramMap.put("invoicenum", 0);
		
		ldao.getInvoicenumByIdAndOrdernum(paramMap);
		
		return ((paramMap.get("invoicenum") == null) ? 0 : Integer.parseInt(paramMap.get("invoicenum").toString()));
	}

	public ArrayList<HashMap<String, Object>> getAllInvoiceList() {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("ref_cursor", null);
		
		ldao.getAllInvoiceList(paramMap);
		
		return (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
	}

	public void insertTransport(int iseq, String logisid, String description, String state) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("iseq", iseq);
		paramMap.put("logisid", logisid);
		paramMap.put("description", description);
		paramMap.put("state", state);
		
		ldao.insertTransport(paramMap);
	}

	public void updateInvoiceState(int iseq, String command, String logisid) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("iseq", iseq);
		paramMap.put("command", command);
		
		ldao.updateInvoiceState(paramMap);
		
		String message = "";
		
		if(command.equals("startCollect"))
			message = "집화 시작";
		else if(command.equals("collectgCompleted"))
			message = "집화 완료";
		else if(command.equals("delivering"))
			message = "배송 중";
		else if(command.equals("deliverCompleted"))
			message = "배송 완료";
		
		if(!message.equals(""))
			insertTransport(iseq, logisid, message, getInvoiceStateByIseq(iseq));
	}

	public ArrayList<HashMap<String, Object>> getTransportListByInvoice(String logisid) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("logisid", logisid);
		paramMap.put("ref_cursor", null);
		
		ldao.getInvoiceListByLogisid(paramMap);
		
		ArrayList<HashMap<String, Object>> invoiceList = (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		
		for(HashMap<String, Object> invoiceVO : invoiceList) {
			//각 invoiceVO에 transportList 저장
			paramMap.put("iseq", Integer.parseInt(invoiceVO.get("ISEQ").toString()));
			paramMap.put("ref_cursor", null);
			
			ldao.getTransportListByIseq(paramMap);
			
			invoiceVO.put("transportList", paramMap.get("ref_cursor"));
		}
		
		return invoiceList;
	}


}
