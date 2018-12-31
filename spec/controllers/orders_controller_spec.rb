require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe '#index' do
    subject { get :index }
    it { is_expected.to have_http_status(:ok) }
  end

  describe '#show' do
    let(:order) { Order.create! }
    subject { get :show, params: { id: order.id } }
    it { is_expected.to have_http_status(:ok) }
  end

  describe '#new' do
    subject { get :new }
    it { is_expected.to have_http_status(:ok) }
  end

  describe '#create' do
    let(:order) { Order.new }
    let(:widget) { Widget.new(name: "Thing", msrp: 2) }
    context 'when a request is valid' do
      let(:line_item) { LineItem.new(quantity: 1, unit_price: 1) }
      let(:valid_params) {
        {
          order: order.attributes.merge(line_items_attributes:
            { '0' => line_item.attributes.merge(widget_attributes: widget.attributes) })
        }
      }
      subject { post :create, params: valid_params }
      it { is_expected.to have_http_status(:found) }
    end
    context 'when a request is invalid' do
      let(:invalid_line_item) { LineItem.new(unit_price: nil) }
      let(:invalid_params) {
        {
          order: order.attributes.merge(line_items_attributes:
            { '0' => invalid_line_item.attributes.merge(widget_attributes: widget.attributes) })
        }
      }
      subject { post :create, params: invalid_params }
      it { is_expected.to have_http_status(:ok) }
    end
  end
end
