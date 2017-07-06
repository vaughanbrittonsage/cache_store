RSpec.describe CacheStore::Marshal do
  describe '#dump' do
    context 'String object' do
      let(:object) { 'foobar' }
      it 'should serialize the string' do
        serialized = subject.dump(object)
        expect(serialized).to be_a(String)
        expect(serialized).to eq JSON.dump({class: String, value: object})
      end
    end
    context 'Integer object' do
      let(:object) { 5 }
      it 'should serialize the integer' do
        serialized = subject.dump(object)
        expect(serialized).to be_a(String)
        expect(serialized).to eq JSON.dump({class: Fixnum, value: object})
      end
    end
    context 'Float object' do
      let(:object) { 5.5 }
      it 'should serialize the float' do
        serialized = subject.dump(object)
        expect(serialized).to be_a(String)
        expect(serialized).to eq JSON.dump({class: Float, value: object})
      end
    end
    context 'Time object' do
      let(:object) { Time.now }
      it 'should serialize the float' do
        serialized = subject.dump(object)
        expect(serialized).to be_a(String)
        expect(serialized).to eq JSON.dump({class: Time, value: object.to_f })
      end
    end
    context 'Date object' do
      let(:object) { Date.today }
      it 'should serialize the date' do
        serialized = subject.dump(object)
        expect(serialized).to be_a(String)
        expect(serialized).to eq JSON.dump({class: Date, value: object.to_s })
      end
    end
    context 'DateTime object' do
      let(:object) { DateTime.now }
      it 'should serialize the date' do
        serialized = subject.dump(object)
        expect(serialized).to be_a(String)
        expect(serialized).to eq JSON.dump({class: DateTime, value: object.to_time.to_i })
      end
    end
    context 'TrueClass object' do
      let(:object) { true }
      it 'should serialize the true value' do
        serialized = subject.dump(object)
        expect(serialized).to be_a(String)
        expect(serialized).to eq JSON.dump({class: TrueClass, value: object })
      end
    end
    context 'FalseClass object' do
      let(:object) { false }
      it 'should serialize the false value' do
        serialized = subject.dump(object)
        expect(serialized).to be_a(String)
        expect(serialized).to eq JSON.dump({class: FalseClass, value: object })
      end
    end
  end

  describe '#load' do
    context 'String object' do
      let(:object) { 'foobar' }
      let(:serialized_object) { JSON.dump({class: String, value: object}) }
      it 'should deserialize the string' do
        value = subject.load(serialized_object)
        expect(value).to be_a(String)
        expect(value).to eq object
      end
    end
    context 'Integer object' do
      let(:object) { 5 }
      let(:serialized_object) { JSON.dump({class: Fixnum, value: object}) }
      it 'should deserialize the integer' do
        value = subject.load(serialized_object)
        expect(value).to be_a(Integer)
        expect(value).to eq object
      end
    end
    context 'Float object' do
      let(:object) { 5.5 }
      let(:serialized_object) { JSON.dump({class: Float, value: object}) }
      it 'should deserialize the float' do
        value = subject.load(serialized_object)
        expect(value).to be_a(Float)
        expect(value).to eq object
      end
    end
    context 'Time object' do
      let(:object) { Time.now }
      let(:serialized_object) { JSON.dump({class: Time, value: object.to_f }) }
      it 'should deserialize the time' do
        value = subject.load(serialized_object)
        expect(value).to be_a(Time)
        expect(value.strftime("%s.%L")).to eq object.strftime("%s.%L")
      end
    end
    context 'Date object' do
      let(:object) { Date.today }
      let(:serialized_object) { JSON.dump({class: Date, value: object.to_s }) }
      it 'should deserialize the date' do
        value = subject.load(serialized_object)
        expect(value).to be_a(Date)
        expect(value).to eq object
      end
    end
    context 'DateTime object' do
      let(:object) { DateTime.now }
      let(:serialized_object) { JSON.dump({class: DateTime, value: object.to_time.to_i }) }
      it 'should deserialize the date' do
        value = subject.load(serialized_object)
        expect(value).to be_a(DateTime)
        expect(value.to_time.to_i).to eq object.to_time.to_i
      end
    end
    context 'TrueClass object' do
      let(:object) { true }
      let(:serialized_object) { JSON.dump({class: TrueClass, value: object }) }
      it 'should deserialize the true value' do
        value = subject.load(serialized_object)
        expect(value).to be_a(TrueClass)
        expect(value).to eq object
      end
    end
    context 'FalseClass object' do
      let(:object) { false }
      let(:serialized_object) { JSON.dump({class: FalseClass, value: object }) }
      it 'should deserialize the false value' do
        value = subject.load(serialized_object)
        expect(value).to be_a(FalseClass)
        expect(value).to eq object
      end
    end
  end
end