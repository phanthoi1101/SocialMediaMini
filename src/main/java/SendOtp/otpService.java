package SendOtp;

import java.util.Random;

public class otpService {
	   public static String generateOtp() {
	        Random rand = new Random();
	        return String.valueOf(100000 + rand.nextInt(900000));
	    }
}
