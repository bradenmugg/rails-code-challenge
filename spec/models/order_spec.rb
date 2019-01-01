require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#shipped?' do
    it { is_expected.to respond_to(:shipped?) }

    context 'when a shipped date exists' do
      before { subject.update(shipped_at: Time.now) }
      it { is_expected.to be_shipped }
    end

    context 'when no shipped date is present' do
      it { is_expected.to_not be_shipped }
    end
  end

  describe '#settings' do
    it { is_expected.to respond_to(:settings) }

    context 'when expedite is present' do
      before { subject.settings(expedite: true) }
      it { is_expected.to be_expedited }
    end

    context 'when expedite is turned on then off' do
      before { subject.settings(expedite: true) }
      before { subject.settings(expedite: false) }
      it { is_expected.not_to be_expedited }
    end

    context 'when returns is present' do
      before { subject.settings(returns: true) }
      it { is_expected.to be_returnable }
    end

    context 'when returns is turned on then off' do
      before { subject.settings(returns: true) }
      before { subject.settings(returns: false) }
      it { is_expected.not_to be_returnable }
    end

    context 'when warehouse is present' do
      before { subject.settings(warehouse: true) }
      it { is_expected.to be_warehoused }
    end

    context 'when warehouse is turned on then off' do
      before { subject.settings(warehouse: true) }
      before { subject.settings(warehouse: false) }
      it { is_expected.not_to be_warehoused }
    end
  end

  describe '.shipped and .unshipped' do
    let!(:shipped) { Order.create(shipped_at: Time.now) }
    let!(:unshipped) { Order.create() }

    describe '.shipped' do
      subject { Order.shipped }
      it { is_expected.to include(shipped) }
      it { is_expected.not_to include(unshipped) }

      context 'when there is an newer shipped order' do
        let!(:new_shipped) { Order.create(shipped_at: Time.now) }
        it { is_expected.to end_with(new_shipped) }
      end
    end

    describe '.unshipped' do
      subject { Order.unshipped }
      it { is_expected.to include(unshipped) }
      it { is_expected.not_to include(shipped) }
    end
  end
end
