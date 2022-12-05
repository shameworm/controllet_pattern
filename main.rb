class Controller
    def notify(_sender, _event)
        raise NotImplementedError, "#{self.class} has not implemented method (#{__method__})"
    end
end

class SuperVisor < Controller
    def initialize(plane_1, plane_2)
        @plane_1 = plane_1
        @plane_1.controller = self
        @plane_2 = plane_2
        @plane_2.controller = self
    end


    def notify(_sender, event)
        if event == "A"
            puts "A"
            @plane_2.do_c
        elsif event == "D"
            puts "D"
            @plane_1.do_b
            @plane_2.do_c
        end
    end
end

class BasePlane
    attr_accessor :controller

    def initialize(controller = nil)
        @controller = controller
    end
end

class Plane1 < BasePlane
    def do_a
        puts "Plane 1 goes to Los Angeles"
        @controller.notify(self, 'A')
    end

    def do_b
        puts "Plane 1 goes to New-York"
        @controller.notify(self, 'B')
    end
end

class Plane2 < BasePlane
    def do_c
        puts "Plane 2 goes to Miami"
        @controller.notify(self, 'C')
    end
    def do_d
        puts "Plane 2 goes to Las Vegas"
        @controller.notify(self, 'D')
    end
end


pl1 = Plane1.new
pl2 = Plane2.new
SuperVisor.new(pl1, pl2)

puts 'Client triggers operation A.'
pl1.do_a

puts "\n"

puts 'Client triggers operation D.'
pl2.do_d


