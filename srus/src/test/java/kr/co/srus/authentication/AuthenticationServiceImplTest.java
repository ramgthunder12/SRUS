package kr.co.srus.authentication;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

import java.time.LocalDateTime;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import kr.co.srus.member.MemberMapper;
import kr.co.srus.rentalbox.RentalBox;
import kr.co.srus.rentalbox.RentalBoxMapper;

@ExtendWith(MockitoExtension.class)
class AuthenticationServiceImplTest {

	@Mock
	private MemberMapper memberMapper;

	@Mock
	private RentalBoxMapper rentalBoxMapper;

	@InjectMocks
	private AuthenticationServiceImpl authenticationService;

	private RentalBox requestRentalBox;

	@BeforeEach
	void setUp() {
		requestRentalBox = new RentalBox();
		requestRentalBox.setNo(1);
		requestRentalBox.setAuthKey("test-card-uid");
	}

	@Test
	void compareCardUID_withinValidWindow_returnsTrue() throws Exception {
		RentalBox storedBox = new RentalBox();
		storedBox.setNo(1);
		storedBox.setAuthKey("test-card-uid");
		storedBox.setAuthIssueDate(LocalDateTime.now().minusSeconds(30));

		when(rentalBoxMapper.select(any(RentalBox.class))).thenReturn(storedBox);

		boolean result = authenticationService.compareCardUID(requestRentalBox);

		assertTrue(result);
		verify(rentalBoxMapper, never()).updateAuth(any(RentalBox.class));
	}

	@Test
	void compareCardUID_withinGracePeriod_returnsTrueAndClearsAuth() throws Exception {
		RentalBox storedBox = new RentalBox();
		storedBox.setNo(1);
		storedBox.setAuthKey("test-card-uid");
		storedBox.setAuthIssueDate(LocalDateTime.now().minusMinutes(1).minusSeconds(2));

		when(rentalBoxMapper.select(any(RentalBox.class))).thenReturn(storedBox);

		boolean result = authenticationService.compareCardUID(requestRentalBox);

		assertTrue(result);
		verify(rentalBoxMapper).updateAuth(any(RentalBox.class));
	}

	@Test
	void compareCardUID_pastGracePeriod_returnsFalseAndClearsAuth() throws Exception {
		RentalBox storedBox = new RentalBox();
		storedBox.setNo(1);
		storedBox.setAuthKey("test-card-uid");
		storedBox.setAuthIssueDate(LocalDateTime.now().minusMinutes(2));

		when(rentalBoxMapper.select(any(RentalBox.class))).thenReturn(storedBox);

		boolean result = authenticationService.compareCardUID(requestRentalBox);

		assertFalse(result);
		verify(rentalBoxMapper).updateAuth(any(RentalBox.class));
	}

	@Test
	void compareCardUID_noAuthKey_returnsFalse() throws Exception {
		RentalBox storedBox = new RentalBox();
		storedBox.setNo(1);
		storedBox.setAuthKey(null);

		when(rentalBoxMapper.select(any(RentalBox.class))).thenReturn(storedBox);

		boolean result = authenticationService.compareCardUID(requestRentalBox);

		assertFalse(result);
		verify(rentalBoxMapper, never()).updateAuth(any(RentalBox.class));
	}

	@Test
	void compareCardUID_rentalBoxNotFound_returnsFalse() throws Exception {
		when(rentalBoxMapper.select(any(RentalBox.class))).thenReturn(null);

		boolean result = authenticationService.compareCardUID(requestRentalBox);

		assertFalse(result);
		verify(rentalBoxMapper, never()).updateAuth(any(RentalBox.class));
	}
}
