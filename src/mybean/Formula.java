package mybean;

import java.util.ArrayList;
import java.util.List;

public class Formula {
	
	private String name;
	private String firstData;
	private String secondData;
	private String symbol;
	private List<String> fixed;
	public Formula() {
		fixed = new ArrayList<String>();
	}
	public Formula(String name,String firstData,String secondData,String symbol) {
		this.firstData = firstData;
		this.secondData = secondData;
		this.name = name;
		this.symbol = symbol;
		this.fixed = new ArrayList<String>();
	}
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * @return the firstData
	 */
	public String getFirstData() {
		return firstData;
	}
	/**
	 * @param firstData the firstData to set
	 */
	public void setFirstData(String firstData) {
		this.firstData = firstData;
	}
	/**
	 * @return the secondData
	 */
	public String getSecondData() {
		return secondData;
	}
	/**
	 * @param secondData the secondData to set
	 */
	public void setSecondData(String secondData) {
		this.secondData = secondData;
	}
	/**
	 * @return the symbol
	 */
	public String getSymbol() {
		return symbol;
	}
	/**
	 * @param symbol the symbol to set
	 */
	public void setSymbol(String symbol) {
		this.symbol = symbol;
	}
	public List<String> getFixed() {
		return fixed;
	}
	public void setFixed(List<String> fixed) {
		this.fixed = fixed;
	}
	
}
