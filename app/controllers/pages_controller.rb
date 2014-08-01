class PagesController < ApplicationController
    def home 
    end
    
    def result
        require 'inifile'
        $inifile = IniFile.load('lib/data.ini')
        if $inifile.nil? then
            puts "GORRAM"
        end
        require 'enigma'
        e=EnigmaCipher.new(params[:rotI].to_i, params[:rotII].to_i, params[:rotIII].to_i, params[:RIoff], params[:RIIoff], params[:RIIIoff], params[:ref].to_i)
        @result=e.encodeString(params[:input],false)
    end
end
