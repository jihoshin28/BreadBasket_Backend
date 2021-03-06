class PhonesController < ApplicationController
    skip_before_action :authorized
    def index
        phones = Phone.where(query_params)
        render json: PhoneSerializer.new(phones)
    end

    def show
        phone = Phone.find(params[:id])
        render json: PhoneSerializer.new(phone)
    end

    def create 
        phone = Phone.create(phone_params)
        if phone.valid?
            render json: PhoneSerializer.new(phone)
        else
            render json: {error: "phone not valid"}
        end
    end

    def update 
        phone = Phone.find(params[:id])
        phone.update(phone_params)
        render json: {update: params[:id]}
    end

    def delete
        phone = Phone.find(params[:id])
        phone.destroy
        render json: {destroy: params[:id]}
    end

    private

    def query_params
        params.permit(:shopper_id, :store_id)
    end

    def phone_params 
        params.require(:phone).permit(:number, :phoneable_type, :phoneable_id)
    end
end
