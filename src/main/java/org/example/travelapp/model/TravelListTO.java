package org.example.travelapp.model;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class TravelListTO {
    private int cpage;
    private int recordPerPage;
    private int pagePerBlock;
    private int totalPage;
    private int totalRecord;
    private int startBlock;
    private int endBlock;

    private List<TravelTO> boardLists;

    public TravelListTO(){
        this.recordPerPage = 5;
        this.pagePerBlock = 5;
    }

    public void setTotalRecord(int totalRecord) {
        this.totalRecord = totalRecord;

        // 총 페이지 수 계산
        this.totalPage = (int)Math.ceil((double)this.totalRecord / this.recordPerPage);

        // 페이지 블럭 계산
        int block = (int)Math.ceil((double)this.cpage / this.pagePerBlock);
        this.startBlock = (block - 1) * this.pagePerBlock + 1;
        this.endBlock = Math.min(startBlock + this.pagePerBlock - 1, this.totalPage);

        System.out.println("pagePerBlock : " + pagePerBlock);
        System.out.println("recordPerPage : " + recordPerPage);
        System.out.println("totalRecord : " + totalRecord);
        System.out.println("totalPage :"+ totalPage);
        System.out.println("startBlock : " + startBlock);
        System.out.println("endBlock : " + endBlock);
    }
}

