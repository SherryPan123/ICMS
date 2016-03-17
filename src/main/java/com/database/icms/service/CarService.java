package com.database.icms.service;

import com.database.icms.domain.Car;

public interface CarService {

	//保存由表单生成的车信息
	void saveCarForm(Car car);

}
