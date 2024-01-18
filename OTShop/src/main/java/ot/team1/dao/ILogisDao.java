package ot.team1.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ILogisDao {

	public void getLogis(HashMap<String, Object> paramMap);

	public void insertInvoice(HashMap<String, Object> paramMap);

	public void getInvoiceStateByIseq(HashMap<String, Object> paramMap);

	public void getInvoiceStateByIdAndOrdernum(HashMap<String, Object> paramMap);

	public void getInvoicenumByIdAndOrdernum(HashMap<String, Object> paramMap);

	public void getAllInvoiceList(HashMap<String, Object> paramMap);

	public void insertTransport(HashMap<String, Object> paramMap);

	public void updateInvoiceState(HashMap<String, Object> paramMap);

	public void getInvoiceListByLogisid(HashMap<String, Object> paramMap);

	public void getTransportListByIseq(HashMap<String, Object> paramMap);

	//public void getTransportListById(HashMap<String, Object> paramMap);
	
	

}
