require 'rails_helper'

RSpec.describe 'Notificationモデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context 'Trainモデルとの関係' do
      it 'N:1となっている' do
        expect(Notification.reflect_on_association(:train).macro).to eq :belongs_to
      end
    end

    context 'TrainCommentモデルとの関係' do
      it 'N:1となっている' do
        expect(Notification.reflect_on_association(:train_comment).macro).to eq :belongs_to
      end
    end

    context 'Roomモデルとの関係' do
      it 'N:1となっている' do
        expect(Notification.reflect_on_association(:room).macro).to eq :belongs_to
      end
    end

    context 'Messageモデルとの関係' do
      it 'N:1となっている' do
        expect(Notification.reflect_on_association(:message).macro).to eq :belongs_to
      end
    end

    context '中間モデルVisitorとの関係' do
      it 'N:1となっている' do
        expect(Notification.reflect_on_association(:visitor).macro).to eq :belongs_to
      end
    end

    context '中間モデルVisitedとの関係' do
      it 'N:1となっている' do
        expect(Notification.reflect_on_association(:visited).macro).to eq :belongs_to
      end
    end
  end
end
