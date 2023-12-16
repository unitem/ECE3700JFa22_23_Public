module TLB(
    input [13:0] virtual_address,
    input [1:0] input_physical_page,
    input update_page,
    output reg [9:0] physical_address,
    output reg page_fault
);
    integer i,j;
    reg valid [3:0];
    reg [1:0] reference [3:0];
    reg hit;
    reg already_written;
    wire [5:0] tag_temp;
    reg [5:0] tag [3:0];
    reg [1:0] translation [3:0];
    assign tag_temp = virtual_address[13:8];

    initial begin
        for (i = 0; i < 4; i = i + 1) valid[i] = 0;
        for (i = 0; i < 4; i = i + 1) reference[i] = 0;
    end

always @ (virtual_address) begin
    hit = 0;
    already_written = 0;
    page_fault = 0;
    for (i = 0; i < 4; i = i + 1) begin
        if (valid[i] == 1 && tag_temp == tag[i]) begin // HIT
            hit = 1;
            reference[i] = 2'b11;
            for (j = 0; j < 4; j = j + 1) begin
                if ((j != i) && (reference[j] != 0)) reference[j] = reference[j] - 1;
            end
            physical_address = {translation[i], virtual_address[7:0]};
        end
    end
    if (hit == 0) begin
        if (update_page) begin
            for (i = 0; i < 4; i = i + 1) begin
                if (valid[i] == 0 && already_written == 0) begin
                    valid[i] = 1;
                    tag[i] = tag_temp;
                    translation[i] = input_physical_page;
                    reference[i] = 2'b11;
                    already_written = 1;
                    for (j = 0; j < 4; j = j + 1) begin
                        if ((j != i) && (reference[j] != 0)) reference[j] = reference[j] - 1;
                    end
                end
            end
            physical_address = {input_physical_page, virtual_address[7:0]};
        end else page_fault = 1;
    end
end

endmodule