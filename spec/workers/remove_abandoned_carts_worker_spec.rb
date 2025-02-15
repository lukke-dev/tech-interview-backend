# frozen_string_literal: true

require 'sidekiq/testing'
require 'rails_helper'

describe RemoveAbandonedCartsWorker do
  context "Quando o servico for enviado para fila" do
    it "Deve ter pelo menos 1 serviço na fila" do
      Sidekiq::Testing.fake! do
        RemoveAbandonedCartsWorker.perform_async
        expect(RemoveAbandonedCartsWorker.jobs.size).to eq(1)
      end
    end
  end
end