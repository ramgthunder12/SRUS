package kr.co.srus.rental;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RentalMapper {
	public void insert(Rental rental) throws Exception;

	public List<Rental> selectAll(Rental rental) throws Exception;
	
	public List<Rental> selectAllById(Rental rental) throws Exception;
	
	public Rental select(Rental rental) throws Exception;

	public void update(Rental rental) throws Exception;
}