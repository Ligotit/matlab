




classdef XCPErrorCode<uint8
    enumeration
        ERR_CMD_SYNCH(0)
        ERR_CMD_BUSY(16)
        ERR_DAQ_ACTIVE(17)
        ERR_PGM_ACTIVE(18)

        ERR_CMD_UNKNOWN(32)
        ERR_CMD_SYNTAX(33)
        ERR_OUT_OF_RANGE(34)
        ERR_WRITE_PROTECTED(35)
        ERR_ACCESS_DENIED(36)
        ERR_ACCESS_LOCKED(37)
        ERR_PAGE_NOT_VALID(38)
        ERR_MODE_NOT_VALID(39)
        ERR_SEGMENT_NOT_VALID(40)
        ERR_SEQUENCE(41)
        ERR_DAQ_CONFIG(42)

        ERR_MEMORY_OVERFLOW(48)
        ERR_GENERIC(49)
        ERR_VERIFY(50)
        ERR_RESOURCE_TEMPORARY_NOT_ACCESSIBLE(52)
        ERR_SUBCMD_UNKNOWN(52)
        ERR_TIMECORR_STATE_CHANGE(53)

        ERR_DBG(252)
    end
end