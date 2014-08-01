module Rotors
    RotorI=1
    RotorII=2
    RotorIII=3
    RotorIV=4
    RotorV=5
    RotorVI=6
    RotorVII=7
    RotorVIII=8
end

module Reflectors
    ReflectorB=1
    ReflectorC=2
end

class EnigmaCipher

    def serRotor(rot)
        case rot
            when Rotors::RotorI
                r = $inifile['RotorI']['array'].split(',')
                n = $inifile['RotorI']['notch'].split('+')
            when Rotors::RotorII
                r = $inifile['RotorII']['array'].split(',')
                n = $inifile['RotorII']['notch'].split('+')
            when Rotors::RotorIII
                r = $inifile['RotorIII']['array'].split(',')
                n = $inifile['RotorIII']['notch'].split('+')
            when Rotors::RotorIV
                r = $inifile['RotorIV']['array'].split(',')
                n = $inifile['RotorIV']['notch'].split('+')
            when Rotors::RotorV
                r = $inifile['RotorV']['array'].split(',')
                n = $inifile['RotorV']['notch'].split('+')
            when Rotors::RotorVI
                r = $inifile['RotorVI']['array'].split(',')
                n = $inifile['RotorVI']['notch'].split('+')
            when Rotors::RotorVII
                r = $inifile['RotorVII']['array'].split(',')
                n = $inifile['RotorVII']['notch'].split('+')
            when Rotors::RotorVIII
                r = $inifile['RotorVIII']['array'].split(',')
                n = $inifile['RotorVIII']['notch'].split('+')
        end
        return r,n
    end
    
    def initialize(rotI, rotII, rotIII, rIoff, rIIoff, rIIIoff, ref)

        case ref
            when 1
                @ref = $inifile['ReflectorB']['array'].split(',')
            when 2
                @ref = $inifile['ReflectorC']['array'].split(',')
        end
        
        @rI,@nI=serRotor(rotI)
        @rII,@nII=serRotor(rotII)
        @rIII,@nIII=serRotor(rotIII)
        
        @I = $inifile['Alphabet']['array'].split(',')
        @aIII = @I.clone
        @aII  = @I.clone
        @aI   = @I.clone
        @aef  = @I.clone

        @rIII.rotate! @I.index rIIIoff
        @aIII.rotate! @I.index rIIIoff
        @rII.rotate! @I.index rIIoff
        @aII.rotate! @I.index rIIoff
        @rI.rotate! @I.index rIoff
        @aI.rotate! @I.index rIoff

    end

    def encodeChar(r1)
        @rIII.rotate! 1
        @aIII.rotate! 1
        
        if @nIII.include? @aIII[25] then
            @rII.rotate! 1
            @aII.rotate! 1
        end
        
        if @nII.include? @aII[25] then
            @rI.rotate! 1
            @aI.rotate! 1
        end

        r2 = @rIII[@I.index r1]
        r3 = @rII[@aIII.index r2]
        r4 = @rI[@aII.index r3]
        r5 = @ref[@aI.index r4]
        r6 = @aI[@aef.index r5]
        r7 = @aI[@rI.index r6]
        r8 = @aII[@aI.index r7]
        r9 = @aIII[@rII.index r8]
        return @I[@rIII.index r9]
    end
  
    def encodeString(input, blocking)
        input.upcase!
        result = ""
        k=0
        for i in 0..input.length-1 do    
            if not input[i] =~ /[\s]/ then
                result += encodeChar input[i]
                k+=1
                if blocking and k==5 then
                    result += " "
                    k=0
                end
            elsif not blocking
                result += " " 
            end
        end
        return result
    end

end
