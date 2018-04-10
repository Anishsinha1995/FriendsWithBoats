public class AnimalResponse {
    
    public class JSON2Apex {
		public Animal animal;
	}

	public class Animal {
		public Integer id;
		public String name;
		public String eats;
		public String says;
	}

	
	public static AnimalResponse parse(String json) {
		return (AnimalResponse) System.JSON.deserialize(json, AnimalResponse.class);
	}

}