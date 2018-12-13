package com.ljn.mall.test;

import java.io.File;

public class Test {

	public static void main(String[] args) {
		String path="D://JuZhiYuan//招聘简历//校园招聘";
		File file=new File(path);
		if (!file.exists()) {
			file.mkdirs();
		}
				
	}
}
