package com.giftiel.shop.common;

import java.lang.reflect.Method;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.document.AbstractXlsView;

@Component("excelDownload")
public class excelView extends AbstractXlsView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String excelName = (String) model.get("excelName");
		String colName = (String) model.get("colName");
		String colMapping = (String) model.get("colMapping");
		List<?> colValue = (List<?>) model.get("colValue");
		boolean totalCls;
		if ((String) model.get("totalCls") ==null)
			totalCls = false;
		else
			totalCls = true;


		response.setContentType("application/msexcel");
		response.setHeader("Content-Disposition", "attachment; filename=" + excelName + ".xls");

		HSSFSheet sheet = (HSSFSheet) workbook.createSheet();

		// 상단 메뉴명 생성
		HSSFRow menuRow = sheet.createRow(0);
		String[] titles = colName.split(",");
		for (int i = 0; i < titles.length; i++) {
			HSSFCell cell = menuRow.createCell(i);
			cell.setCellValue(new HSSFRichTextString(titles[i]));
		}

		String[] mapping = colMapping.split(",");
		String[] totalValue = new String[mapping.length];
		for (int i = 0; i < totalValue.length; i++) {
			totalValue[i] = "0";
		}
		int mi = 0;
		for (int i = 0; i < colValue.size(); i++) {
			Class<?> temClass = colValue.get(i).getClass();
			temClass = colValue.get(i).getClass();
			Method[] methods = colValue.get(i).getClass().getMethods();
			HSSFRow row = sheet.createRow(i + 1);

			mi = 0;
			for (int j = 0; j < mapping.length; j++) {
				for (Method m : methods) {
		           if (m.getName().startsWith("get") && !m.getName().startsWith("getClass")) {
		               if(mapping[j].equals(m.getName())){
		            	   Object value = m.invoke(colValue.get(i));
		            	   try {
		            		   totalValue[mi] = (Integer.parseInt(totalValue[mi]) + Integer.parseInt(value.toString()))+"";
		            	   } catch (Exception e) {
		            		   totalValue[mi] = "";
		            	   }
			               HSSFCell cell = row.createCell(mi);
			               cell.setCellValue(new HSSFRichTextString(value+""));
			               mi++;
		               }
		           }
				}
			}
		}

		if(totalCls){
			HSSFRow row = sheet.createRow(colValue.size()+1);
			HSSFCell cell = row.createCell(0);
			cell.setCellValue(new HSSFRichTextString("합계"));
			for (int i = 1; i < totalValue.length; i++) {
				cell = row.createCell(i);
				cell.setCellValue(new HSSFRichTextString(totalValue[i]));
			}

		}
	}
}