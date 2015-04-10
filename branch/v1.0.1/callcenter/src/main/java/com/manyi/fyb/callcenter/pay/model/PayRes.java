package com.manyi.fyb.callcenter.pay.model;

import java.io.Serializable;
import java.math.BigDecimal;

public class PayRes  implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3042265041671678055L;
	private int payId;
	private String userName;//经纪人名称
	private String mobile;//经纪人手机号码
	private String account;//支付宝帐号
	private int userState;//用户状态
	private String userStateStr;
	private BigDecimal paySum;//支付金额
	private int payState;//支付状态
	private String payStateStr;
	private String payReason;//付款理由
	
	public String getPayReason() {
		return payReason;
	}
	public void setPayReason(String payReason) {
		this.payReason = payReason;
	}
	public int getPayId() {
		return payId;
	}
	public void setPayId(int payId) {
		this.payId = payId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public int getUserState() {
		return userState;
	}
	public void setUserState(int userState) {
		this.userState = userState;
	}
	public String getUserStateStr() {
		return userStateStr;
	}
	public void setUserStateStr(String userStateStr) {
		this.userStateStr = userStateStr;
	}
	public BigDecimal getPaySum() {
		return paySum;
	}
	public void setPaySum(BigDecimal paySum) {
		this.paySum = paySum;
	}
	public int getPayState() {
		return payState;
	}
	public void setPayState(int payState) {
		this.payState = payState;
	}
	public String getPayStateStr() {
		return payStateStr;
	}
	public void setPayStateStr(String payStateStr) {
		this.payStateStr = payStateStr;
	}
	
}
