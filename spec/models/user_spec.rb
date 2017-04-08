RSpec.describe User, type: :model do
    it { should have_many(:identities).dependent(:destroy) }
    it { should have_many(:publishes).dependent(:destroy) }
    it { should have_one(:site).dependent(:destroy) }
    it { should have_one(:vk_group).dependent(:destroy) }
    it { should have_many(:albums).through(:vk_group) }
    it { should validate_presence_of :role }
    it { should validate_inclusion_of(:role).in_array(%w(user admin)) }

    it 'should be valid' do
        user = create :user

        expect(user).to be_valid
    end

    it 'should be valid with email and password' do
        user = User.new email: 'example@gmail.com', password: 'password'

        expect(user).to be_valid
    end

    it 'should be invalid without email' do
        user = User.new email: nil
        user.valid?

        expect(user.errors[:email]).to include("can't be blank")
    end

    it 'should be invalid without password' do
        user = User.new password: nil
        user.valid?

        expect(user.errors[:password]).to include("can't be blank")
    end

    it 'should be invalid with a duplicate email' do
        User.create email: 'example@gmail.com', password: 'password'
        user = User.new email: 'example@gmail.com', password: 'password'
        user.valid?
        
        expect(user.errors[:email]).to include('has already been taken')
    end

    describe 'callbacks' do
        context 'create_sites_objects' do
            it 'should create new vk_group for user' do
                expect { create :user }.to change(VkGroup, :count).by(1)
            end

            it 'should create new site for user' do
                expect { create :user }.to change(Site, :count).by(1)
            end
        end
    end

    describe 'methods' do
        context '.find_for_oauth' do

        end

        context '.is_admin?' do
            it 'should return true if user is admin' do
                user = create :user, :admin

                expect(user.is_admin?).to eq true
            end

            it 'should return false if user is not admin' do
                user = create :user

                expect(user.is_admin?).to eq false
            end
        end
    end
end
