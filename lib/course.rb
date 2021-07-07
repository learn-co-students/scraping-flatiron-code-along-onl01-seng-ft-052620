class Course

    attr_accessor :title, :schedule, :description

    @@all = []

    def initialize
        self.save
    end

    def self.all
        @@all
    end
    
    def save
        @@all << self
    end
    
    def self.reset_all
        self.all.clear
    end
    
end