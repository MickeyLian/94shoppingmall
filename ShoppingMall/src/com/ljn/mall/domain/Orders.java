package com.ljn.mall.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Orders {
  
    private String oid;				//订单id（流水号）
    private Date ordertime;			//订单交易时间
    private Double total;			//总金额
    private Integer state;			//订单状态    (1：未付款；2：已付款，未发货；3：已发货，没收货；4：收货，订单结束)
    							    //买家：下单未付款，付款未发货，已发货，签收 ；卖家：未付款，发货，未签收，已收货（结束）
    private String address;			//收货人地址
    private String name;			//收货人姓名
    private String telephone;		//收货人电话
    private User user;				//会员的会员id
    private List<Orderitem> list=new ArrayList<Orderitem>();  //订单和订单项的关系
    public String getOid() {
        return oid;
    }

    public void setOid(String oid) {
        this.oid = oid == null ? null : oid.trim();
    }

    public Date getOrdertime() {
        return ordertime;
    }

    public void setOrdertime(Date ordertime) {
        this.ordertime = ordertime;
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }

    public Integer getState() {
        return state;
    }

    /**
     * 订单状态    (1：未付款；2：已付款，未发货；3：已发货，没收货；4：收货，订单结束)
     * @param state
     */
    public void setState(Integer state) {
        this.state = state;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone == null ? null : telephone.trim();
    }

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<Orderitem> getList() {
		return list;
	}

	public void setList(List<Orderitem> list) {
		this.list = list;
	}

	@Override
	public String toString() {
		return "Orders [oid=" + oid + ", ordertime=" + ordertime + ", total=" + total + ", state=" + state
				+ ", address=" + address + ", name=" + name + ", telephone=" + telephone + ", user=" + user + ", list="
				+ list + "]";
	}
	
    
}