package com.database.icms.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.database.icms.domain.Fare;


@Service
public interface FareService {
	List<Fare> findAllFare();
	List<Fare> findAllFareByPage( Integer pageNo,Integer pageSize );
}
