package kr.co.srus.rentalbox;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RentalBoxMapper {
	public void insert(RentalBox rentalBox) throws Exception;

	public List<RentalBox> selectAll(RentalBox rentalBox) throws Exception;

	public RentalBox select(RentalBox rentalBox) throws Exception;

	public void update(RentalBox rentalBox) throws Exception;
	
	public void updateAuth(RentalBox rentalBox) throws Exception;
}