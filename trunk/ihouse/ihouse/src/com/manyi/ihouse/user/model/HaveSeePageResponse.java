package com.manyi.ihouse.user.model;

import com.manyi.ihouse.base.PageResponse;

/**
 * 行程 - 已看的 Response模型
 * @author hubin
 *
 */
public class HaveSeePageResponse extends PageResponse<HaveSeeModel> {
	
	private String assigneeName; //经纪人姓名
	
	private String assigneeTel; //经纪人电话
    
    private String assigneePhotoUrl; //经纪人照片URL

    private float score; //经纪人评分
	
	public String getAssigneePhotoUrl() {
        return assigneePhotoUrl;
    }

    public void setAssigneePhotoUrl(String assigneePhotoUrl) {
        this.assigneePhotoUrl = assigneePhotoUrl;
    }

    public float getScore() {
        return score;
    }

    public void setScore(float score) {
        this.score = score;
    }

    public String getAssigneeName() {
		return assigneeName;
	}

	public void setAssigneeName(String assigneeName) {
		this.assigneeName = assigneeName;
	}

	public String getAssigneeTel() {
		return assigneeTel;
	}

	public void setAssigneeTel(String assigneeTel) {
		this.assigneeTel = assigneeTel;
	}

}
