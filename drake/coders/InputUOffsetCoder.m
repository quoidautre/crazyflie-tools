classdef InputUOffsetCoder < LCMCoder
  % getting u, broadcasting 10000*(u+offset)-32768
  
  properties
    offset;
  end
  
  methods
    function obj = InputUOffsetCoder(offset)
      obj = obj@LCMCoder();
      obj.offset = offset;
    end
    function [u,t] = decode(obj,data)
      msg = crazyflie_t.crazyflie_thrust_t(data);
      u = (1/10000)*([msg.thrust1 msg.thrust2 msg.thrust3 msg.thrust4]'+32768)-obj.offset;
      t = msg.timestamp;
    end
    function msg = encode(obj,t,u)
      msg = crazyflie_t.crazyflie_thrust_t();
      thrust = min(65000,10000*(u+obj.offset));
      thrust = max(0,thrust)-32768;
      msg.thrust1 = thrust(1);
      msg.thrust2 = thrust(2);
      msg.thrust3 = thrust(3);
      msg.thrust4 = thrust(4);
      msg.timestamp = t;
    end
    function d = dim(obj)
      d = 4;
    end
    function str = timestampName(obj)
      str = 'timestamp';
    end
    function names = coordinateNames(obj)
      names = {'thrust1','thrust2','thrust3','thrust4'};
    end
  end

end
